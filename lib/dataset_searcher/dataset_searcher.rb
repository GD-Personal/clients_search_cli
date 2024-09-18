require "json"
require "byebug"

class DatasetSearcher
  attr_reader :data

  def initialize(data_file_path)
    @data_file_path = data_file_path
    @data = load_data
    @result = []
  end

  def search(query, fields = nil)
    @data.select { |data| data.matches?(query, fields) }
  end

  def find_duplicate_emails
    duplicates = {}
    data_by_email = {}

    @data.each do |data|
      email = data.email.downcase
      data_by_email[email] ||= []
      data_by_email[email] << data
    end

    data_by_email.each do |key, value|
      duplicates[key] = value if value.size > 1
    end

    duplicates.values.flatten
  end

  # Displays results to the console
  def display_results(results, output = $stdout)
    if results.empty?
      output.puts "No data found."
    else
      results.each do |result|
        output.puts result.attributes.map { |k, v| "#{k}: #{v}" }.join(", ")
      end
      output.puts "Found #{results.size} result(s)!"
    end
  end

  private

  def load_data(output = $stdout)
    file = File.read(@data_file_path)
    results = JSON.parse(file)
    results.map do |result|
      Dataset.new(result)
    end
  rescue Errno::ENOENT
    output.puts("Client data file not found at #{@data_file_path}!")
    []
  rescue JSON::ParserError
    output.puts("Invalid JSON!")
    []
  end
end
