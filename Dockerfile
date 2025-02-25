# Ruby ubuntu image
FROM ruby:3.4.1-bookworm

# mkdir /app && cd /app
WORKDIR /app

# Maybe remove this later to avoid running our website on 'stale' database
COPY db/minitwit.db ./db/minitwit.db

# Copy and install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# This is entrypoint for production
COPY config.ru ./

# Assuming these will change pretty often so putting them low in the cache chain
COPY public/stylesheets ./public/stylesheets
COPY views ./views
COPY minitwit.rb  ./

CMD ["rackup", "--host", "0.0.0.0", "-p", "4567"]
