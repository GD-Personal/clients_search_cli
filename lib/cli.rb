require "optparse"

require "./lib/client_searcher/client"
require "./lib/client_searcher/client_searcher"

output = $stdout
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: make run [options]"

  opts.on("-d", "--dataset_path FILE", "Path to the dataset file. Supported format: json") do |file|
    options[:dataset_path] = file
  end

  opts.on("-q", "--query QUERY", "Search query") do |query|
    options[:query] = query
  end

  opts.on("-f", "--fields SEARCH FIELD", "An array of searchable fields") do |fields|
    options[:fields] = fields
  end

  opts.on("-c", "--command COMMAND", "The command to perform (e.g search, find_duplicate_email)") do |command|
    options[:command] = command
  end

  opts.on("-h", "--help", "Prints this help") do
    output.puts opts
  end
end.parse!

dataset_path = options[:dataset_path].to_s.empty? ? "./data/clients.json" : options[:dataset_path]
client_searcher = ClientSearcher.new(dataset_path)

case options[:command]
when "search"
  query = options[:query]
  fields = options[:fields].to_s.empty? ? nil : options[:fields].delete(" ").split(",")

  output.puts "\nSearching for #{query} in #{fields}..."
  result = client_searcher.search(query, fields)
  client_searcher.display_results(result)

when "find_duplicate_emails"
  output.puts "\nFinding duplicate emails..."
  result = client_searcher.find_duplicate_emails
  client_searcher.display_results(result)

when nil
  # do nothing
else
  output.puts "\nCommand #{options[:command]} not available.\n\n"
end
