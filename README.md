[![Github Actions](https://github.com/GD-Personal/clients_search_cli/actions/workflows/ci.yml/badge.svg)](https://github.com/GD-Personal/clients_search_cli/actions/workflows/ci.yml) [![Maintainability](https://api.codeclimate.com/v1/badges/bee0f26fa1a8000b9994/maintainability)](https://codeclimate.com/github/GD-Personal/clients_search_cli/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/bee0f26fa1a8000b9994/test_coverage)](https://codeclimate.com/github/GD-Personal/clients_search_cli/test_coverage)

# Clients Search CLI

## Description
This is a CLI application built with Ruby that would search through a JSON dataset with clients. 

Available commands:
- `search`: searches through all clients and return those with names partially matching a given search query
- `find_duplicates`: finds out if there are any clients with the same email in the dataset, and show those duplicates if any are found.

## Setup
This application is using ruby 3.2.2 with the following tools:
- [RSpec](https://rspec.info/) for testing
- [standardrb](https://github.com/standardrb/standard) for linting
- [bundler-audit](https://github.com/rubysec/bundler-audit) for checking Gemfile's vulnerability issues
- [Byebug](https://github.com/deivid-rodriguez/byebug) for debugging
- [Make](https://www.gnu.org/software/make/) for build tasks
- [Github Actions](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions) for CI

### 🐳 Docker
The easiest way to run this application is by using docker to make sure you have the correct development environment.
#### Pre-requisites
Docker installed on your machine (See [Docker Installation Guides](https://docs.docker.com/get-started/introduction)).
```
❯ docker-compose build
❯ docker-compose run app
```

### Or you could still run it without docker
#### Intall Ruby with one of the following:
- [Using RVM](https://rvm.io/rvm/install) or with
- [the asdf version manager](https://github.com/asdf-vm/asdf-ruby)

## Run the CLI
```
❯ make run command=search query=john fields=full_name
ruby ./lib/cli.rb search --dataset_path= --query=john --fields=full_name

❯ make run command=search query=william fields=full_name,email
ruby ./lib/cli.rb search --dataset_path= --query=william --fields=full_name,email

❯ make run command=find_duplicate_emails
ruby ./lib/cli.rb find_duplicate_emails --dataset_path= --query= --fields=

❯ make help
ruby ./lib/cli.rb --help
```

### Testing
```
❯ make test
bundle exec rspec
```

### Coding standard
Use `make lint` to check code for style issues.

```
❯ make lint
bundle exec standardrb lib spec
```

### Security audit
Use `make audit` to check vulnerability issues of the gems in Gemfile.lock
```
❯ make audit
bundle exec bundle-audit check --update
```