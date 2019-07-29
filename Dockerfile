FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /petlove
WORKDIR /petlove

COPY Gemfile /petlove/Gemfile
COPY Gemfile.lock /petlove/Gemfile.lock

RUN bundle install

COPY . /petlove
