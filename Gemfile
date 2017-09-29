source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

#source "https://rails-assets.org"
#gem 'rails-assets-bootstrap', ">= 4.0.0.alpha.2"
#gem 'rails-assets-tether'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# use Webpack
gem 'webpacker', '~> 3.0'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use postgres as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


group :development do
    gem 'platform-api'
    gem "better_errors"
    gem "binding_of_caller"
end




group :production do
  gem 'redis', '~> 3.0'

end   



# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


gem 'twitter-bootstrap-rails'
#gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'simple_form'
gem 'devise'
gem "font-awesome-rails"
gem "cancan"
#gem "paperclip", "~> 5.0.0"
gem "paperclip", git: "git://github.com/thoughtbot/paperclip.git"
gem "delayed_paperclip"
#
gem 'dotenv-rails', groups: [:development]
gem 'aws-sdk', '~> 2'
gem 'friendly_id', '~> 5.1.0' # Note: You MUST use 5.0.0 or greater for Rails 4.0+

gem 'aasm'
gem 'geocoder'
gem 'namecase', '~> 2.0'

gem 'bootstrap', '~> 4.0.0.alpha6'
#gem 'bootstrap', git: 'https://github.com/twbs/bootstrap-rubygem'
gem 'sprockets', '~> 3.0'

gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'jquery-rails'
gem 'mini_magick'
#gem 'mini_magick', '~> 4.1.0'
gem 'jquery-ui-rails', '~> 6.0', '>= 6.0.1'
#gem 'jquery-ui-rails'
gem "gritter", "1.2.0"
#gem 'carrierwave', '~> 1.0'
#gem 'carrierwave-aws', '~> 1.1'
gem 'dropzonejs-rails'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
#gem 'omniauth-twitter', '~> 1.4', '>= 1.4.0'
gem 'omniauth-twitter', :github => 'arunagw/omniauth-twitter'
gem 'toastr-rails'
gem 'sendgrid-ruby'
gem 'ransack'
gem 'ratyrate'
gem 'omniauth-stripe-connect'
gem 'country_select'
gem 'twilio-ruby', '~> 4.11.1'

gem 'fullcalendar-rails', '~> 3.4.0'
gem 'momentjs-rails', '~> 2.17.1'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'

#gem 'stripe'
gem 'stripe', '~> 3.0.0'
gem 'rails-assets-card', source: 'https://rails-assets.org'

gem 'chartkick', '~> 2.2.4'

gem 'pusher'
gem 'roadie', '~> 3.2'

gem 'delayed_job_active_record'

# gems fron instacart
gem 'marginalia'
#gem 'ahoy_email'

