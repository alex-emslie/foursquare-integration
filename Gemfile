source 'https://rubygems.org'


gem 'rails', '4.1.6'
gem 'unicorn' # server
gem 'pg'
gem "devise" # user auth flow
gem 'devise_invitable'
gem 'acts_as_taggable_on'
gem "figaro"
gem 'haml-rails' # makes rails create haml in generators, etc.
gem 'redcarpet'
gem 'jquery-rails'
gem 'simple-navigation'
gem 'faraday', '~> 0.8'
gem 'faraday_middleware', '>= 0.8'
gem 'hashie', '>= 1.0', '< 3.0.0'
group :development do
  gem 'thin' # Use thin as the webserver in dev to suppress those stupid "cannot determine content-length" errors
  gem "quiet_assets", ">= 1.0.1"  # don't tell me about assets being served in the logs
  gem "better_errors", ">= 0.3.2"  # cant live without.
  gem 'therubyracer' # For multios development
  gem "binding_of_caller"
end
# Use SCSS for stylesheets
group :assets do
  gem 'sass-rails', '~> 4.0.3'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.0.0'
end

group :test do
  gem 'sqlite3' # test db
  gem "capybara", ">= 2.0.1"
  # gem "database_cleaner", ">= 1.2.0" # clears the database between tests
  gem "database_cleaner", git: 'https://github.com/bmabey/database_cleaner.git'
  gem "launchy", "~> 2.1.2" # lets capybara launch your browser
  gem 'rb-fsevent', '~> 0.9.1' # filesystem change event watcher
  gem 'capybara-mechanize' # fill out forms/click links with capybara
  gem "poltergeist" # headless javascript browser
  gem "shoulda" # adds some extra helpful validation helpers to should
  gem 'resque_spec' #a test double of Resque for rspec and cucumber
end
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
