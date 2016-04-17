#!/bin/bash

set -e

cd /vagrant


echo INSTALLING GGTRACKER
# install ggtracker
(cd ggtracker && \
  bundle && \
  cp -np config/secrets.yml{.example,} && \
  cp -np config/s3.yml{.example,} && \
  rake db:create && \
  bundle exec rake db:schema:load)

echo INSTALLING ESDB
(cd esdb && \
  cp -np config/database.yml{.example,} && \
  bundle && \
  (mysql -u root <<-"EOF"
	create database if not exists esdb_development;
	create database if not exists esdb_test;
EOF
) && \
  cp -np config/s3.yml{.example,} && \
  cp -np config/fog.rb{.example,} && \
  cp -np config/redis.yml{.example,} && \
  cp -np config/esdb.yml{.example,} && \
  cp -np config/tokens.yml{.example,} && \
  bundle exec sequel -m db/migrations -e development config/database.yml && \
  cat db/replays_sq_skill_stat.sql | mysql -u root -D esdb_development && \
  cat db/ggtracker_provider.sql | mysql -u root -D esdb_development && \
  bundle exec rake py:init && \
  bundle exec sequel -m db/migrations -e test config/database.yml && \
  echo RUNNING TESTS && \
  bundle exec rspec)

echo DONE install-ggtrackerstack.sh
