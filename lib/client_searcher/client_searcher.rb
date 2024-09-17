require "json"
require "logger"

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
    output.puts("Client data file not found!")
    exit
  end
end
