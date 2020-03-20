require "dotenv"
require "httparty"
require "table_print"

require_relative "workspace"

Dotenv.load

SLACK_TOKEN = ENV["SLACK_TOKEN"]
p SLACK_TOKEN
BASE_URL = "https://slack.com/api/channels.list?"

query = { token: SLACK_TOKEN }

response = HTTParty.get(BASE_URL, query: query)
# p response

# def main
#   puts "Welcome to the Ada Slack CLI!"
#   workspace = Workspace.new

#   # TODO project

#   puts "Thank you for using the Ada Slack CLI"
# end

# main if __FILE__ == $PROGRAM_NAME
