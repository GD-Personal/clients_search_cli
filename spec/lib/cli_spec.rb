# spec/json_cli_spec.rb
require 'spec_helper'

RSpec.describe 'CLI App' do
  describe 'command=search' do
    let(:data_path) { "./spec/data/dataset.json" }

    it 'returns search results for valid file and arguments' do
      expect do
        # Simulate running the CLI with ARGV
        system("ruby lib/cli.rb search --dataset_path #{data_path} --query john")
      end.to output(/john/).to_stdout_from_any_process
    end
  
    it 'returns empty array when no match is found' do
      expect do
        system("ruby lib/cli.rb search --dataset_path #{data_path} --query nonexistent")
      end.to output(/No data found/).to_stdout_from_any_process
    end
  
    it 'prints "File not found" if file does not exist' do
      expect do
        system("ruby lib/cli.rb search --dataset_path nonexistent.json --query john")
      end.to output(/Dataset file not found/).to_stdout_from_any_process
    end
  
    it 'prints nothing for invalid JSON file' do
      invalid_file = 'spec/data/invalid.json'
      File.write(invalid_file, 'invalid json data')
  
      expect do
        system("ruby cli.rb search --dataset_path #{invalid_file} --query john")
      end.to output("").to_stdout_from_any_process
  
      File.delete(invalid_file)
    end
  end
end
