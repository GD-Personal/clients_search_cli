require "./lib/client_searcher/client"
require "./lib/client_searcher/client_searcher"

# Main app goes here
# Accept CLI args of a file path
# Process the file
# Check against our dataset by using the ClientSearcher

json_file_path = "./data/client.json"

search_query = "john"
search_field = nil
client_searcher = ClientSearcher.new(json_file_path)
result = client_searcher.search(search_query, search_field)
client_searcher.display_results(result)

