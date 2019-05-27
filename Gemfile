source "https://rubygems.org"

ruby "2.6.3"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "coffee-rails", "~> 4.2"
gem "devise"
gem "jsonapi-resources"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.7"
gem "pundit"
gem "rails", "~> 5.1.5"
gem "rspec"
gem "rspec-rails"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "verbs"
# gem 'aws-sdk', '~> 2.3'
gem "aws-sdk-s3"
gem "paperclip"
gem "rack-cors", require: "rack/cors"
gem "mqtt"

group :development, :test do
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "jsonapi-rspec"
  gem "pry"
  gem "pry-remote"
  gem "rspec-json_expectations"
  gem "rubocop"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
