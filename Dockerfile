FROM ruby:2.5

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends postgresql-client \
  libpq-dev \
  build-essential \
  git \
  curl \
  apt-transport-https \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists

# install Node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
  && apt-get install -y nodejs \
  && apt-get install -y build-essential

# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update \
  && apt-get -yqq install yarn \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists/*

RUN npm install puppeteer --only=dev

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

#CMD rails server -b 0.0.0.0
