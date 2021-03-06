source 'https://rubygems.org'
ruby "2.0.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc1'

# Use sqlite3 as the database for Active Record
gem 'pg', '~> 0.17'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc1'

gem 'bootstrap-sass'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
gem 'haml_coffee_assets'
gem 'execjs'

gem 'thinking-sphinx', '~> 3.0.2', require: 'thinking_sphinx'
gem 'mysql2', '~> 0.3.12b4'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner'

end

group :production do
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
  gem 'flying-sphinx',   '1.0.0'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
end

gem 'devise', '~> 3.0.0.rc'
gem 'haml-rails'

gem 'ancestry', git: 'https://github.com/stefankroes/ancestry.git'

gem 'will_paginate', '~> 3.0'
gem 'will_paginate-bootstrap'

gem 'cancan'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
