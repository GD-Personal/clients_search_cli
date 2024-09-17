default: test

.PHONY: lint
lint:
	bundle exec standardrb -a lib spec

.PHONY: test
test:
	bundle exec rspec

.PHONY: audit
audit:
	bundle exec bundle-audit check --update
