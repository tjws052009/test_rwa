# INIT!

bundle install --path=vendor/bundle

myql -uroot < config/setup.sql

test
