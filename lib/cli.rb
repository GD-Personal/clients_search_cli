require "optparse"
require "flexi/json"

output = $stdout
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: make run command=search [options].\nAvailable commands: search, find_duplicate_fields.\nAvailable options:"

  opts.on("-d", "--dataset_path FILE", "Path to the dataset file. Supported format: json") do |file|
    options[:dataset_path] = file
  end

  opts.on("-q", "--query QUERY", "Search query") do |query|
    options[:query] = query
  end

  opts.on("-f", "--fields SEARCH FIELD", "An array of searchable fields") do |fields|
    options[:fields] = fields
  end

  opts.on("-h", "--help", "Prints this help") do
    output.puts opts
  end
end.parse!

dataset_path = options[:dataset_path].to_s.empty? ? "./data/dataset.json" : options[:dataset_path]
data = Flexi::Json::Loader.new(dataset_path).load_data
flexi_json_searcher = Flexi::Json::Searcher.new(data)

main_command = ARGV[0]
case main_command
when "search"
  query = options[:query]
  fields = options[:fields].to_s.empty? ? nil : options[:fields].delete(" ").split(",")

  output.puts "\nSearching for #{query} in #{fields || "all fields"}..."
  result = flexi_json_searcher.search(query, fields)
  flexi_json_searcher.display_results(result)

when "find_duplicate_emails"
  output.puts "\nFinding duplicate emails..."
  result = flexi_json_searcher.find_duplicates("email")
  flexi_json_searcher.display_results(result)

when nil
  output.puts "\nPlease pass a command argument. See --help"
else
  output.puts "\nCommand '#{main_command}' is not available.\nSee --help (or `make help`) for available commands and options.\n\n"
end
