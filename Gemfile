source 'https://rubygems.org'


gem 'rails', '4.1.5'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'bourbon'
gem 'jbuilder', '~> 2.0'
gem 'activerecord-session_store'
gem "haml"
gem "haml-rails"
gem 'haml_coffee_assets', git: "https://github.com/netzpirat/haml_coffee_assets"
gem 'execjs'
gem 'css_splitter'
gem "browser"

gem 'devise', '~> 3.3.0'
gem 'cancancan'
gem "stamp", "~> 0.4.0"
gem 'stamp-i18n'
gem 'rails-i18n'
gem 'kaminari'
gem 'http_accept_language'

group :production, :development do
  gem 'redis'
  gem "redis-store", :require => "redis-store"
  gem 'redis-rails'
end

group :test, :development do
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  gem "timecop"

  gem 'factory_girl_rails'
  gem "rspec-rails", '~> 2.99'
end

group :test do
  gem 'launchy'
  gem 'database_cleaner'
  gem "fuubar"
  gem "capybara"
  gem 'poltergeist'
  gem 'cucumber-rails', :require => false
  gem "headless"
end

group :development do
  gem 'spring'
  gem 'quiet_assets'
  gem "better_errors"
  gem "binding_of_caller"
  gem "spring-commands-rspec"
  gem "spring-commands-cucumber"
end

group :doc do
  gem 'sdoc', '~> 0.4.0'
end
