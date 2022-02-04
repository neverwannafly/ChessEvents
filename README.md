# CHESS ON RAILS
<img src="https://elasticbeanstalk-ap-south-1-707854657814.s3.ap-south-1.amazonaws.com/assets/chess-on-rails-cover.png" height="200px" />

This project is the IInd iteration of playchess app previously written in Python (Flask).
This version offers much more fluid and better chess learning experience to the users.

## Demo
Application is hosted on
https://www.chessonrails.com/

## Tech Stack
- Ruby on Rails
- React
- AWS Elastic Beanstalk
- Mysql 5.7

## Running locally
- Please set this ENV variable to your local mysql database password: `WEB_BLACK_LILY_DEV_DATABASE_PASSWORD`

### Rails Server
- `bundle install`
- `rails s`

### Webpack server
- `yarn install`
- `bin/webpack-dev-server`
