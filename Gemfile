source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '4.2'

# Postgresql
gem 'pg'
gem 'pg_search'
gem 'dalli'

# File/Image upload handler
gem 'carrierwave'
gem 'fog', '~> 1.27.0'
gem 'rmagick', '2.13.2'

# Haml for views, scss stylesheets, uglifier js compressor and coffee-js
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'therubyracer'
gem 'coffee-rails', '~> 4.1.0'
gem 'uglifier', '>= 1.3.0'
gem 'haml', '>= 3.0.0'
gem 'haml-rails'
gem 'neat'
gem 'execjs'

# User authentication
gem 'devise'
# Markdown
gem 'rdiscount'
gem 'pagedown-rails', '~> 1.1.3'
# Friendly URLs
gem 'friendly_id'
# Fast tweet buttons view helper
gem 'tweet-button'
# Analytics
gem 'newrelic_rpm'
gem 'exception_notification'
# Quick string diff checker
gem 'differ'
# Quick tags for models, and active resource for star model.
gem 'acts-as-taggable-on', '~> 3.4'
gem 'activeresource' # maybe activeresource is not needed

group :development do
  gem 'thin'
  gem 'meta_request', '0.2.0'
  gem 'guard'
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
end

group :development, :test do
  # Rspec for testing
  gem 'rspec-rails', '>= 2.0.1'
  gem 'factory_girl_rails', '~> 4.5.0'
end

group :production do
  # Requirement to push to Heroku
  gem 'rails_12factor'
end
