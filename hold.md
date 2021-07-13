# syntax=docker/dockerfile:1
FROM ruby:2.5.3-alpine
ENV BUNDLER_VERSION=2.0.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler -v 2.0.2
RUN bundle update
RUN bundle install

# Add a script to be executed every time the container starts.
ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
# ENTRYPOINT ["./bin/docker-entrypoint.sh"]
# ENTRYPOINT ["sh", "/docker-entrypoint.sh"]
# ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]