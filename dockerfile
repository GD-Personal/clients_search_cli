# Use the official Ruby image from the Docker Hub
FROM ruby:3.2.2-alpine

# Install dependencies
RUN apk add --no-cache \
    build-base \
    bash \
    libpq-dev \
    git

# Set the working directory
WORKDIR /shiftcare

# Copy the application codes except for specs
COPY Gemfile Gemfile.lock ./
# Install the gems specified in the Gemfile
RUN bundle

COPY . .

# Make the Ruby script executable
RUN chmod +x Makefile

# RUN the executable file
ENTRYPOINT ["bash"]