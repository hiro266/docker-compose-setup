FROM ruby:3.0.2
RUN apt-get -qq update && \
    apt-get install -y --no-install-recommends gnupg apt-transport-https ca-certificates && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/yarn.gpg && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get -qq update && apt-get install -y --no-install-recommends yarn && apt-get install -y nodejs vim && \
    mkdir /docker-compose-setup

WORKDIR /docker-compose-setup
COPY Gemfile /docker-compose-setup/Gemfile
COPY Gemfile.lock /docker-compose-setup/Gemfile.lock
RUN bundle install
COPY . /docker-compose-setup

# puma.sockの置き場所
RUN mkdir -p tmp/sockets

RUN yarn install --check-files
