source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Backend begin
gem 'puma', '~> 4.1'
gem 'pg', '1.1.4'
gem 'redis', '~> 4.0'
gem 'rails', '~> 6.0.1'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'foreman', '0.86.0'
gem 'sidekiq', '5.2.7'
gem 'devise', '4.7.1'
gem 'jwt', '2.2.1'
gem 'rswag-api', '2.2.0'
gem 'rswag-ui', '2.2.0'
gem 'whenever', '1.0.0', require: false
gem 'active_hash', '3.1.0'
gem 'globalize', '~> 5.3'
gem 'inherited_resources', '1.11.0'
gem 'kaminari', '1.2.0'
gem 'pundit', '2.1.0'
gem 'searchkick', '4.2.0'
gem "aws-sdk-s3", '1.61.1', require: false
gem 'rack-attack', '6.3.0'
gem 'oj', '3.10.6'
gem 'fast_jsonapi', '~> 1.5'
# Backend end

# Frontend begin
gem 'webpacker', '~> 4.0'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem "view_component", '2.1.0'
gem 'image_processing', '~> 1.2'
# Frontend end

gem 'stripe', '5.22.0'
gem 'stripe_event', '2.3.1'
gem 'postmark-rails', '0.20.0'
gem 'pdfkit', '0.8.4.3.1'
# gem 'wkhtmltopdf-binary', '0.12.6.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '3.9.0'
  gem 'rswag-specs', '2.2.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'capistrano', '~> 3.7',         require: false
  gem 'capistrano-rbenv', '2.1.3'
  gem 'capistrano-rails', '~> 1.2',   require: false
  gem 'capistrano-bundler', '~> 1.2', require: false
  gem 'capistrano3-puma', '~> 1.2',   require: false
  gem "capistrano-yarn"
  gem 'capistrano-shell'
  gem 'capistrano-sidekiq', '1.0.0'
  # gem 'checked', git: 'git@gitlab.com:igorpavlov-ip/checked.git' # checked.pro local gem
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'database_cleaner', '1.7.0'
  gem 'simplecov', '0.17.1', require: false
  gem 'factory_bot_rails', '5.1.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
