Local Setup Prerequisites
================
- git
- rvm
- Ruby 2.5.3
- Postgres 9.6

Getting started
==============
Clone the repo
```
$ git clone git@github.com:manishnagdewani96170/customer_app.git
```
Load ruby version (RVM as example)
```
$ rvm install "ruby-2.5.3"
```
After Ruby has been installed, download the Bundler package if you don't already have it:
```
$ gem install bundler
```
Load all gems
```
$ bundle install
```
Create file with variables, by copying: 
```
$ cp .env.example .env
```
Database setup
```
$ rake db:setup
```
Running the app
>**Note:** Before continuing, ensure Postgres services are running in the background.
```
$ rails server -p 3000
```