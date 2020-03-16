require 'simplecov'
SimpleCov.start do
  add_filter 'test/workspace_test'
  add_filter 'test/channel_test'
  add_filter 'test/user_test'
  add_filter 'test/recipient_test'
  add_filter 'test/slack_test'
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'vcr'
# require "webmock/minitest"
require 'dotenv'
require 'HTTParty'
Dotenv.load 

require_relative "../lib/workspace.rb"
require_relative "../lib/channel.rb"
require_relative "../lib/user.rb"
require_relative "../lib/recipient.rb"
require_relative "../lib/slack.rb"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new



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

  config.filter_sensitive_data("<SLACK_API_TOKEN>") do
    ENV["SLACK_API_TOKEN"]
  end

  config.filter_sensitive_data("<BOT_API_TOKEN>") do
    ENV["BOT_API_TOKEN"]
  end
end
