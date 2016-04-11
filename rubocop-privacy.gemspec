$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'rubocop/privacy/version'

Gem::Specification.new do |s|
  s.name = 'rubocop-privacy'
  s.summary = 'Vertical alignment checking for Ruby files'
  s.description = <<-EOS
    Vertical alignment checker to ensure method definitions are in the following order:
      1. Public
      2. Protected
      3. Private
  EOS
  s.homepage = 'https://github.com/mojotech/rubocop-privacy'
  s.authors = ['Micah Frost', 'Craig P Jolicoeur']
  s.email = ['micah@mojotech.com', 'craig@mojotech.com']
  s.license = 'MIT'

  s.version = RuboCop::Privacy::Version::STRING
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.3'

  s.require_paths = ['lib']
  s.files = Dir[
    'lib/**/*.rb'
  ]
  s.test_files = Dir['spec/**/*.rb']
  s.extra_rdoc_files = ['LICENSE', 'README.md']

  s.add_dependency 'rubocop', '~> 0.37.0'

  s.add_development_dependency 'bundler', '~> 1.3'
end
