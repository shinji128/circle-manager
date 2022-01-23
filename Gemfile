source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.5'

gem 'rails', '~> 6.1.4', '>= 6.1.4.4'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'net-smtp', require: false
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootsnap', '>= 1.4.4', require: false
gem 'image_processing', '~> 1.2'

group :development, :test do
  gem 'bullet' # N+1検知
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'factory_bot_rails'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman' #脆弱性診断 'bundle exec brakeman'
  gem 'rails_best_practices' #https://github.com/flyerhzm/rails_best_practices
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false

  gem 'web-console', '>= 4.1.0'
  # パフォーマンス情報をブラウザで表示（本番環境での表示も可）: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'capybara'
  gem 'webdrivers'
end