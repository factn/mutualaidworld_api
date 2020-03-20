FROM ruby:2.6.5

ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt update
RUN apt-get install -y nodejs postgresql-client

RUN mkdir /myapp
WORKDIR /myapp

RUN gem install bundler

COPY .ruby-version /myapp/.ruby-version
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN bundle install

COPY . /myapp

EXPOSE 3000
CMD bundle exec puma -C config/puma.rb

LABEL maintainer="Talal Arshad <talal7860@gmail.com>"
