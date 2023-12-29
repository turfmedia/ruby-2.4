FROM --platform=linux/amd64 ruby:2.4.9 as builder
LABEL maintainer="Stéphane Busso <stephane.busso@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

# make sure the package repository is up to date and update ubuntu
RUN  apt-get update &&  apt-get install -q -y debconf locales curl


# RUN dpkg-reconfigure locales && \
#   locale-gen en_US.UTF-8 && \
#   /usr/sbin/update-locale LANG=en_US.UTF-8

# ENV LANG en_US.UTF-8
# ENV LANGUAGE en_US.UTF-8
# ENV LC_ALL en_US.UTF-8
ENV HOME /root
ENV RUBY_VERSION 2.4.9

# Install ruby-install / ignore
RUN apt-get update && \
  apt-get install -y -q --no-install-recommends git nano htop libxml2-dev libxslt-dev libcurl4-openssl-dev libreadline-dev libssl-dev patch build-essential zlib1g-dev openssh-server libicu-dev libyaml-dev libxslt-dev libffi-dev libpq-dev patch libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev \
  postgresql-client \
  nodejs && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# RUN curl -LO https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
#   tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
#   mv phantomjs-2.1.1-linux-x86_64 /usr/local/share && \
#   ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin

# Install Bundler for each version of ruby
RUN echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc
# && \
# gem update --system

RUN mkdir /www
WORKDIR /www
