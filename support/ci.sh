#!/bin/sh

set -e

if [ -d support/redmine ] ; then
  echo "Enter Redmine dir"
  cd support/redmine

  echo "Removing previous redmine_tags"
  rm -rf vendor/plugins/redmine_tags
else
  echo "Setting up Redmine"
  git clone git://github.com/redmine/redmine.git support/redmine

  echo "Enter Redmine dir"
  cd support/redmine

  echo "Checking out branch 1.4"
  git checkout origin/1.4-stable

  echo "Creating up database.yml"
  echo "test:"                       >  config/database.yml
  echo "  adapter:  sqlite3"         >> config/database.yml
  echo "  database: db/test.sqlite3" >> config/database.yml
fi

echo "Cloning the plugin to Redmine plugins folder"
git clone ../.. vendor/plugins/redmine_tags

echo "Bundling Redmine"
RAILS_ENV=test bundle install --without="rmagick mysql postgresql"

echo "Migrating database"
RAILS_ENV=test REDMINE_LANG=en \
  bundle exec rake \
  db:drop db:create db:migrate db:migrate_plugins redmine:load_default_data
