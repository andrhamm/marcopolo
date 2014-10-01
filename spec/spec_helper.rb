ENV["RAILS_ENV"] ||= 'test'
require 'marcopolo'

require 'simplecov'
require 'rspec'
require 'webmock/rspec'
require 'rack'
require 'byebug'

# WebMock.disable_net_connect! allow_localhost: true

RSpec.configure do |config|
  config.order = 'random'

  config.before(:each) {
  }
end

