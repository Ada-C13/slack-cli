#!/usr/bin/env ruby
require "httparty"
require "dotenv"
require_relative "workspace"
Dotenv.load

SLACK_TOKEN = ENV["SLACK_TOKEN"]

def test
url = "https://slack.com/api/channels.list?token=#{SLACK_TOKEN}&pretty=1"
response = HTTParty.get(url)

 
channel_list = []
response["channels"].each do |channel|
channel_list << channel["name"]
end

return channel_list

end
 p test


 # {
#   "Our_channels" => {
#     :name => respnse[0]["channels"]["name"]
#   }
# }
# def main
#   puts "Welcome to the Ada Slack CLI!"
#   workspace = Workspace.new

#   # TODO project

#   puts "Thank you for using the Ada Slack CLI"
# end

# main if __FILE__ == $PROGRAM_NAME
