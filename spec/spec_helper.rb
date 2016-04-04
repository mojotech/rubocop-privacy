require 'rubocop'

privacy_path = File.join(File.dirname(__FILE__), '..')
rubocop_path = File.join(privacy_path, 'vendor', 'rubocop')

unless File.directory?(rubocop_path)
  raise 'Need a local RuboCop checkout.  Please refer to the README.md file.'
end

Dir["#{rubocop_path}/spec/support/**/*.rb"].each { |f| require f }
Dir["#{privacy_path}/spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |c|
  c.order = :random

  c.expect_with :rspec do |exp|
    exp.syntax = :expect # Disable `should`
  end

  c.mock_with :rspec do |m|
    m.syntax = :expect # Dsiable `should_receive` and `stub`
  end
end

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH.unshift File.dirname(__FILE__)
require 'rubocop-privacy'
