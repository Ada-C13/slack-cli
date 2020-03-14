require "simplecov"
SimpleCov.start do
  add_filter "test/"
end

require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"
require "vcr"
# Do I keep this?
# require "dotenv"
# Dotenv.load

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

  # tells VCR not to put token into cassette file
  config.filter_sensitive_data("SLACK_TOKEN") do
    ENV["SLACK_TOKEN"]
  end
end

# Any tests involving a User should use the username SlackBot
# Any tests involving a Channel should use the #random channel

# Do not need to test your main command loop, or the user interaction portions of your app. However, all classes and helper methods should be thoroughly tested.

# Follow TDD best practices (pseudocode, red, green, refactor)
# Add tests for all code you write
# Make sure all tests are green before pushing to GitHub
# Make sure all tests are green after you pull
