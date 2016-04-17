#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

add-apt-repository ppa:chris-lea/redis-server -y

apt-get update

# GGTRACKER dependencies
apt-get install -y \
  ruby redis-server nodejs npm mysql-server git-core ruby-dev \
  libcurl4-openssl-dev libmysqlclient-dev build-essential libxml2-dev \
  libxslt-dev

# ESDB dependencies
apt-get install -y \
  memcached imagemagick libsasl2-dev python-pip python-dev libtiff5-dev \
  libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev \
  tk8.6-dev python-tk

gem install bundler
npm install -g juggernaut

# Juggernaut looks for `node` instead of `nodejs`
sudo ln -s /usr/bin/nodejs /usr/bin/node
