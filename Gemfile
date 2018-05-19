source 'https://rubygems.org'

ruby '2.5.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'forest', github: 'dylanfisher/forest'
gem 'rails', '~> 5.2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'jbuilder'
gem 'autoprefixer-rails'
gem 'figaro'
gem 'dalli'
gem 'connection_pool'
gem 'bootsnap', require: false
gem 'faker'

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
  # gem 'guard'
  # gem 'guard-livereload', require: false
  # gem 'marginalia'
end
