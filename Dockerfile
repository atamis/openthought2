FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /vendor
WORKDIR /vendor
COPY Gemfile /vendor/Gemfile
COPY Gemfile.lock /vendor/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /vendor
