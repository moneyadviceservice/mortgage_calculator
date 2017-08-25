# Docker image to run the tests in Jenkins.

FROM ubuntu:17.04
MAINTAINER development.team@moneyadviceservice.org.uk

# Allow other repositories to be installed.
RUN apt-get update -q \
    && DEBIAN_FRONTEND="noninteractive" apt-get install \
            -qy \
            -o Dpkg::Options::="--force-confnew" \
            --no-install-recommends \
                apt-transport-https \
                curl \
                software-properties-common \
    && apt-get autoremove -q \
    && apt-get clean -qy \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f /var/cache/apt/*.bin

# Install node repository.
RUN add-apt-repository -y -r ppa:chris-lea/node.js
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

RUN echo 'deb https://deb.nodesource.com/node_8.x zesty main' > /etc/apt/sources.list.d/nodesource.list
RUN echo 'deb-src https://deb.nodesource.com/node_8.x zesty main' >> /etc/apt/sources.list.d/nodesource.list

# Install needed packages.
RUN apt-get update -q \
    && DEBIAN_FRONTEND="noninteractive" apt-get upgrade \
            -qy \
            -o Dpkg::Options::="--force-confnew" \
            --no-install-recommends \
    && DEBIAN_FRONTEND="noninteractive" apt-get install \
            -qy \
            -o Dpkg::Options::="--force-confnew" \
            --no-install-recommends \
                # add packages one per line, in alphabetical order
                build-essential \
                git \
                libfontconfig \
                libssl-dev \
                libsqlite3-dev \
                libxml2-dev \
                nodejs \
                rbenv \
                ruby \
                ruby-build \
                ruby-bundler \
                ruby-dev \
                zlib1g-dev \
    && apt-get autoremove -q \
    && apt-get clean -qy \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f /var/cache/apt/*.bin

# Fetch phantomjs -- preferred over the one that ships with Ubuntu, because
# it does not have a dependency on X11 being installed and configured
RUN curl -L -O https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar jxf phantomjs-2.1.1-linux-x86_64.tar.bz2 \
        -C /usr/bin --strip-components 2 \
        phantomjs-2.1.1-linux-x86_64/bin/phantomjs

# Install bower.
RUN echo '{ "allow_root": true }' > /root/.bowerrc
RUN npm install -g bower

# Install the ruby and node dependencies.
# This caches them in the docker image, provided the package files do not
# change, so the test script will execute much faster.
RUN mkdir -p /var/tmp/gem/lib/mortgage_calculator
WORKDIR /var/tmp/gem

COPY .ruby-version /var/tmp/gem/
COPY Gemfile mortgage_calculator.gemspec /var/tmp/gem/
COPY lib/mortgage_calculator/version.rb /var/tmp/gem/lib/mortgage_calculator/

ENV RAILS_ENV test
ENV BUNDLE_WITHOUT development:build
RUN bundle install

COPY bower.json.erb /var/tmp/gem/
RUN bundle exec bowndler install

COPY package.json /var/tmp/gem/
RUN npm install

# Set up the Jenkins user, in order to run the tests not as root.
RUN useradd -ms /bin/bash -u 115 jenkins
USER jenkins
