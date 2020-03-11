require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'dotenv'
require 'vcr'
require 'pry'

Dotenv.load('lib/.env')

require_relative '../lib/channel'
require_relative '../lib/member'
require_relative '../lib/recipient'
require_relative '../lib/slack'
require_relative '../lib/workspace'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes"
  config.hook_into :webmock
end

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes" 
  config.hook_into :webmock 
  config.default_cassette_options = {
    :record => :new_episodes,    # record new data when we don't have it yet
    :match_requests_on => [:method, :uri, :body], # The http method, URI and body of a request all need to match
  }

  # Don't leave our token lying around in a cassette file.
  config.filter_sensitive_data("<SLACK_TOKEN>"){
    ENV['SLACK_TOKEN']}
end
