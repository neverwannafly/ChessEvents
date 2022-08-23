# CHESS ON RAILS
<img src="https://elasticbeanstalk-ap-south-1-707854657814.s3.ap-south-1.amazonaws.com/assets/chess-on-rails-cover.png" height="200px" />

This project is the 2nd iteration of playchess app previously written in Python (Flask).
This version offers much more fluid and better chess learning experience to the users.
Note: This site is actively under development and soon aims to get aligned with the vision we provide

## Current Roadmap for 2022
- Seamless puzzle solving experience with daily goals and rewards
- Weekly puzzle tournaments
- Provide basic engine analysis facilities to users
- Content Management system for providing users with fresh chess content
- Very Personalized chess traning programms totally free of cost.

## Demo
Application is hosted on
https://www.chessonrails.com/

## Tech Stack
- Ruby on Rails
- React
- Docker
- AWS Elastic Beanstalk
- Mysql 5.7

## Running locally
#### Build
- `docker-compose pull`
- `docker-compose run api bundle install`. This step is essential for making changes on local machine reflect on docker container. More on this issue is here: https://github.com/docker/compose/issues/2103#issuecomment-172888391

#### Run
- `docker-compose up`
