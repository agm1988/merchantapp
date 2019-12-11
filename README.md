# MerchantPay
# Requirements
- Ruby ~> 2.5
- postgresql >= 9.5
- redis >= 4.0
- yarn
- webpack

# Using Docker
- Go to project folder
- run `docker-compose build`
- run `docker-compose up`
- create database and run migrations
- seed data
- login to app container
`docker exec -it merchantpay_app_1 bash`
- start webpack-dev-server
`bin/webpack-dev-server`
- start sidekiq
`bundle exec sidekiq -C config/sidekiq.yml`
- refer to database.yml.example and .env.example
for setting up ENV vars.

To open app go to: `localhost:3002`

Maybe you would need to install dependencies:
`bundle install` and `yarn` but this should be handled by docker

If you will see error on creating db, try:
`docker-compose run app rake db:create`
