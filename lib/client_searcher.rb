require 'json'
require 'logger'

class ClientSearcher
  attr_reader :clients

  def initialize(data_file_path, logger = Logger.new(STDOUT))
    @data_file_path = data_file_path
    @clients = load_data
    @logger = logger
  end

  def search(query, fields = Client::SEARCHABLE_FIELDS)
    @logger.info("Search initiated with query: '#{query}', Fields: #{fields.join(', ')}")
    result = @clients.select { |client| client.matches?(query, fields) }

    if result.empty?
      @logger.warn("No results found for search query: '#{query}'")
    else
      @logger.info("#{result.size} results found for query: '#{query}'")
    end
    
    result
  end

  private

  def load_data
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
    @logger.error("Client data file not found!")
    exit
  end

  # Displays results to the console
  def display_results(results)
    if results.empty?
      puts "No clients found."
    else
      results.each do |client|
        puts "ID: #{client.id}, Name: #{client.full_name}, Email: #{client.email}"
      end
    end
  end
end
