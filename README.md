# Clients Search CLI

## Description
This is a CLI application built with Ruby that would search through a JSON dataset with clients. There are 2 commands available:
1. Search through all clients and return those with names partially matching a given search query
2. Find out if there are any clients with the same email in the dataset, and show those duplicates if any are found.

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