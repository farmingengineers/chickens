FROM ruby:2.1.9 as base

WORKDIR /app
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
# This will get vendor/cache, if it exists, without breaking if it doesn't.
ADD vendor vendor
RUN bundle install --local || bundle install

# Prepare by downloading https://nodejs.org/dist/v10.16.0/node-v10.16.0-linux-x64.tar.xz
ARG NODE_VERSION=v10.16.0-linux-x64
COPY node-${NODE_VERSION}.tar.xz /node.tar.xz
RUN cd / && tar xf node.tar.xz --strip-components 1 -C /usr/local

FROM base
ADD . .
RUN bin/rake db:migrate RAILS_ENV=test
RUN bin/rspec
