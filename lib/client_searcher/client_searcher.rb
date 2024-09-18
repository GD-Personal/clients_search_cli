require "json"
require "byebug"

class ClientSearcher
  attr_reader :clients

  def initialize(data_file_path)
    @data_file_path = data_file_path
    @clients = load_data
    @result = []
  end

  def search(query, fields = Client::SEARCHABLE_FIELDS)
    @clients.select { |client| client.matches?(query, fields) }
  end

  def find_duplicate_emails
    duplicates = {}
    clients_by_email = {}

    @clients.each do |client|
      email = client.email.downcase
      clients_by_email[email] ||= []
      clients_by_email[email] << client
    end

    clients_by_email.each do |key, value|
      duplicates[key] = value if value.size > 1
    end

    duplicates.values.flatten
  end

  # Displays results to the console
  def display_results(results, output = $stdout)
    if results.empty?
      output.puts "No clients found."
    else
      results.each do |client|
        output.puts "ID: #{client.id}, Name: #{client.full_name}, Email: #{client.email}"
      end
      output.puts "Found #{results.size} results!"
    end
  end

  private

  def load_data(output = $stdout)
    file = File.read(@data_file_path)
    data = JSON.parse(file)
    data.map do |client|
      Client.new(
        id: client["id"],
        full_name: client["full_name"],
        email: client["email"]
      )
    end
  rescue Errno::ENOENT
    output.puts("Client data file not found at #{@data_file_path}!")
    exit
  end
end
