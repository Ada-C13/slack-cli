require_relative 'workspace'
require 'dotenv'
Dotenv.load
API_KEY = ENV['SLACK_TOKEN']
require 'HTTParty'
base_url = 	'https://slack.com/api/channels.list'
query_param = {
  token: API_KEY
}
channel_list = HTTParty.get(base_url, query: query_param)
require 'ap'
channel_list.parsed_response["channels"].each do |channel|
  ap bananna["name"]
end


def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME