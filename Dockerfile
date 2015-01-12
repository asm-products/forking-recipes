FROM ruby:1.9.3-wheezy

# Install tools & libs to compile everything
RUN apt-get update && apt-get install -y build-essential libmagickwand-dev imagemagick

RUN mkdir /forking-recipes
WORKDIR /forking-recipes

ADD Gemfile /forking-recipes/Gemfile
ADD Gemfile.lock /forking-recipes/Gemfile.lock
RUN bundle install

ADD . /forking-recipes
