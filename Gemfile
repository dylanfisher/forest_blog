source 'https://rubygems.org'

ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'forest', github: 'dylanfisher/forest'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
# gem 'redis'
# Use ActiveModel has_secure_password
# gem 'bcrypt'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'figaro'

gem 'dalli'
gem 'connection_pool'

gem 'aws-sdk'

# TODO: does this work on Heroku?
gem 'bootsnap', require: false

group :production do
  gem 'heroku-deflater', github: 'dylanfisher/heroku-deflater'
  gem 'rack-cors'
end

group :development do
  gem 'pry-rails'

  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
  # Guard is a command line tool to easily handle events on file system modifications. http://guardgem.org
  gem 'guard'
  gem 'guard-livereload', require: false

  # gem 'marginalia'
end
