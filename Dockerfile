FROM ruby:3.0.2

RUN apt-get update -qq && apt-get install -y --no-install-recommends nodejs postgresql-client libvips42

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

COPY Gemfile Gemfile.lock ./
ADD . /Rails-Docker
WORKDIR /Rails-Docker

RUN bundle install

# Add a script to be executed every time the container starts.
#COPY entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]
#EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]

# docker-compose up -d
# docker-compose down

# list containers running
# docker container ls -a

# build the app
# docker build --tag myapp .

# run: tell Docker to map Docker's port 3000 to operating system
# docker run -p 3000:3000 myapp

# docker-compose up

# When we add packages and want to install the packages.
# docker compose up --build