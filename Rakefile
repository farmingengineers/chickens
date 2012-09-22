#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

MattsChickens::Application.load_tasks

task :deploy do
  sh 'git push git@heroku.com:chickens.git master'
  sh 'heroku run bundle exec rake db:migrate'
end
