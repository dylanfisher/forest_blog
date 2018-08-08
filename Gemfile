source 'https://rubygems.org'

ruby '2.5.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'forest', github: 'dylanfisher/forest', branch: 'image_optim'
gem 'rails', '~> 5.1.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
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
  gem 'guard'
  gem 'guard-livereload', require: false
  gem 'rails-erd', require: false

  # gem 'marginalia'
end
