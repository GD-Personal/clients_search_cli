require "spec_helper"
require "byebug"

RSpec.describe ClientSearcher do
  let(:data_path) { "./data/clients.json" }

  describe "#search" do

    subject { described_class.new(data_path) }

    context "for a clients.json file" do
      context "when searching against a client's name" do
        context "when there is a match" do
          it "returns the matched client" do
            result = subject.search("john", ["full_name"])
            expect(result).not_to eq []
            expect(result.first.full_name.downcase).to match(/john/)
          end

          it "returns a collection of Client object" do
            result = subject.search("john", ["full_name"])
            expect(result.first.class).to eq Client
          end
        end

        context "when there is no match" do
          it "returns an empty result" do
            result = subject.search("nonexistent", ["full_name"])
            expect(result).to eq []
          end
        end
      end

      context "when searching against a client's email" do
        context "when there is a match" do
          it "returns the matched client" do
            result = subject.search("michael", ["email"])
            expect(result).not_to eq []
            expect(result.first.email.downcase).to match(/michael/)
          end

          it "returns a collection of Client object" do
            result = subject.search("michael", ["email"])
            expect(result.first.class).to eq Client
          end
        end

        context "when there is no match" do
          it "returns an empty result" do
            result = subject.search("nonexistent", ["email"])
            expect(result).to eq []
          end
        end
      end

      context "when no field is passed" do
        context "when there is a match" do
          it "searches for all searchable fields" do
            result = subject.search("william")
            expect(result).not_to eq []
            expect(result.first.email.downcase).to match(/william/)
          end
        end

        context "when there is no match" do
          it "returns an empty result" do
            result = subject.search("nonexistent")
            expect(result).to eq []
          end
        end
      end
    end
  end

  describe "#find_duplicate_emails" do

    subject { described_class.new(data_path) }

    context "when there is a duplicate" do
      it 'returns the duplicate emails' do
        expect(subject.find_duplicate_emails.size).to eq 2
      end
    end

    context "when there is no duplicate" do
      let(:data_path) { "./data/unique_clients.json" }
      it 'returns an empty array' do
        expect(subject.find_duplicate_emails).to eq []
      end
    end
  end
end
