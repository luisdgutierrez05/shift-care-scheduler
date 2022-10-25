source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
gem "sassc-rails"

# Allows you to generate your JSON in an object-oriented and convention-driven manner.
gem 'active_model_serializers', '~> 0.10.13'

# Flexible authentication solution for Rails with Warden
gem 'devise', '~> 4.8', '>= 4.8.1'

# The speed of a single-page web application without having to write any JavaScript.
gem 'turbo-rails', '~> 1.3', '>= 1.3.1'

# Track changes to your models, for auditing or versioning.
gem 'paper_trail', '~> 13.0'

# Generate beautiful API documentation
gem 'rswag', '~> 2.0', '>= 2.0.5'

group :test do
  # Strategies for cleaning databases.
  gem 'database_cleaner', '~> 2.0', '>= 2.0.1'

  # provides one-liners to test common Rails functionality.
  gem 'shoulda-matchers', '~> 5.2'

  # Code coverage for Ruby with a powerful configuration library and automatic merging of coverage across test suites
  gem 'simplecov', require: false

  gem 'faker', '~> 2.23'
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  # rspec-rails is a testing framework for Rails 5+.
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'

  # provides integration between factory_bot and rails 5.0 or newer
  gem 'factory_bot_rails', '~> 6.2'

  # Extracting `assigns` and `assert_template` from ActionDispatch.
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Annotates Rails/ActiveRecord Models based on the database schema.
  gem 'annotate', '~> 3.2'

  # Automatic Rails code style checking tool.
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end
