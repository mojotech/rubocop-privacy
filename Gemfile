source 'https://rubygems.org'

gemspec

group :development do
  gem 'pry'
  gem 'pry-byebug', platforms: :mri
end

group :test do
  gem 'rake', '~> 10.4', require: false
  gem 'rspec', '~> 3.4', require: false
end

group :release do
  gem 'github_changelog_generator', '~> 1.9', require: false
end

local_gemfile = 'Gemfile.local'
if File.exist?(local_gemfile)
  eval(File.read(local_gemfile)) # rubocop:disable Lint/Eval
end
