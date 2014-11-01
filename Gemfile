source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.3'

# Use mysql2 as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# CORS definitions rack middleware
gem 'rack-cors', :require => 'rack/cors'

# Authentication
gem 'devise'

# Active model serializator
gem 'active_model_serializers'

# OAuth authorization
gem 'doorkeeper'

# Memcache connector - https://github.com/mperham/dalli
gem 'dalli'
gem 'memcachier'

# New Relic
gem 'newrelic_rpm'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'rb-fsevent', :group => :development

group :development do
  # improve errors read and interaction
  gem 'better_errors'
  # N+1 detection
  gem 'bullet'
  # better rails console
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'awesome_print'
  gem 'pry-debugger'
  # watch for best practices for rails
  # gem 'rails_best_practices'
  # gem 'guard-rails_best_practices'

  #  used to migrate legacy data
  # gem 'pg'
  # used to enable console on error page
  gem 'binding_of_caller'
  # For testing OAuth2 clients
  gem 'oauth2'
  # For testing REST calls
  gem 'rest-client'

  gem 'video_info'

end

group :development, :test do
  gem 'rspec-rails'
  # watch and run tests
  gem 'guard-rspec'
  # watch and run migrations
  gem 'guard-migrate'
  # FS events for mac
  # gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  # factory_girl also on development, to replace fixtures
  gem 'factory_girl_rails'
  # Fake data generator
  gem 'faker'
  gem 'database_cleaner'
end
