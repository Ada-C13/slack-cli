require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require "webmock/minitest" #added
require 'vcr'
# require "dotenv"  #added
# Dotenv.load   #added

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative "../lib/workspace.rb"
require_relative "../lib/slack.rb"
require_relative "../lib/user.rb"
require_relative "../lib/channel.rb"
require_relative "../lib/recipient.rb"

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes"
  config.hook_into :webmock
end

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes" # folder where casettes will be located
  config.hook_into :webmock # tie into this other tool called webmock
  config.default_cassette_options = {
    :record => :new_episodes,    # record new data when we don't have it yet
    :match_requests_on => [:method, :uri, :body], # The http method, URI and body of a request all need to match
  }
  config.filter_sensitive_data("SLACK_TOKEN") do
    ENV["SLACK_TOKEN"]
  end
  # Don't leave our token lying around in a cassette file.

end



