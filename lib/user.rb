require "dotenv"
require "httparty"

require_relative "recipient"

Dotenv.load

USER_BASE_URL = "https://slack.com/api/users.list"
# SLACK_TOKEN = ENV["SLACK_TOKEN"]

class User # < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(name:, slack_id:, real_name:, status_text:, status_emoji:)
    # super(name: name, slack_id: slack_id)
    @name = name
    @slack_id = slack_id
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def self.list_all
    data = HTTParty.get("#{USER_BASE_URL}?token=#{SLACK_TOKEN}")
    @user_data = data["members"]
    output = @user_data.map do |user|
      self.new(
        name: user["name"],
        slack_id: user["id"],
        real_name: user["real_name"],
        status_text: user["profile"]["status_text"],
        status_emoji: user["profile"]["status_emoji"],
      )
    end
    return output
  end

  def details(each)
    return "Username: #{name}, 
    Real name: #{real_name}, 
    Slack id: #{slack_id}"
  end
end

# Sample output

# "members": [
#   {
#       "id": "USLACKBOT",
#       "team_id": "TV63QKAAU",
#       "name": "slackbot",
#       "deleted": false,
#       "real_name": "Slackbot",
#       "profile": {
#           "real_name": "Slackbot",
#           "real_name_normalized": "Slackbot",
#           "display_name": "Slackbot",
#           "display_name_normalized": "Slackbot",
#           "fields": null,
#           "status_text": "",
#           "status_emoji": "",
#           "first_name": "slackbot",
#           "last_name": "",
#           "status_text_canonical": "",
#           "team": "TV63QKAAU"
#       },
#       "is_admin": false,
#       "is_owner": false,
#       "is_primary_owner": false,
#       "is_restricted": false,
#       "is_ultra_restricted": false,
#       "is_bot": false,
#       "is_app_user": false,
#       "updated": 0
#   },
# {
#   "id": "UUT9Z80AE",
#   "team_id": "TV63QKAAU",
#   "name": "thenora",
#   "real_name": "Nora",
#   "tz": "America\/Los_Angeles",
#   "tz_label": "Pacific Daylight Time",
#   "tz_offset": -25200,
#   "profile": {
#       "title": "",
#       "phone": "",
#       "skype": "",
#       "real_name": "Nora",
#       "real_name_normalized": "Nora",
#       "display_name": "",
#       "display_name_normalized": "",
#       "status_text": "",
#       "status_emoji": "",
#       "status_text_canonical": "",
#       "team": "TV63QKAAU"
#   },
#   "is_admin": true,
#   "is_owner": true,
#   "is_primary_owner": true,
#   "is_restricted": false,
#   "is_ultra_restricted": false,
#   "is_bot": false,
#   "is_app_user": false,
#   "updated": 1583868865
# },
