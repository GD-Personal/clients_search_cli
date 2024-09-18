default: run

.PHONY: run
run:
	ruby ./lib/cli.rb --dataset_path=$(dataset_path) --command=$(command) --query=${query} --fields=$(fields)

.PHONY: help
help:
	ruby ./lib/cli.rb --help

.PHONY: lint
lint:
	bundle exec standardrb -a lib spec

.PHONY: test
test:
	bundle exec rspec

.PHONY: audit
audit:
	bundle exec bundle-audit check --update
