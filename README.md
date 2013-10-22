# Startup News

[![Build Status](https://travis-ci.org/codelandev/startup_news.png?branch=master)](https://travis-ci.org/codelandev/startup_news)
[![Code Climate](https://codeclimate.com/github/codelandev/startup_news.png)](https://codeclimate.com/github/codelandev/startup_news)


Requirements and install:
- Ruby 2.0.0
- PostgreSQL
- `gem install bundler`
- `bundle install`
- `rake db:create db:migrate db:test:load`
- `rails server`

If you want Google Analytics, in production you just need set environment variable ENV["GOOGLE_ANALYTICS_TRACKER"].
On Heroku, just set `heroku config:set GOOGLE_ANALYTICS_TRACKER="your-key-go-here"` replacing `your-key-go-here` with your key
Or if you have your own server, `export GOOGLE_ANALYTICS_TRACKER="your-key-go-here"` replacing `your-key-go-here` with your key

----------------------------------

Tests
- `rspec .`
