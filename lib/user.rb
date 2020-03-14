require 'httparty'
require 'dotenv'
Dotenv.load
require_relative 'recipient'


class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji
  def initialize(real_name:, status_text:, status_emoji:, slack_id:, name:)
    super(slack_id: slack_id, name: name )
   
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
    
  end

  def details
    
  end
  
  def self.list_all

    url = "https://slack.com/api/users.list"
    response = User.get(url)

    raise SlackApiError.new("Invalid response from API") if response.code != 200 || response["ok"] == false

    all_user_array = []
    response["members"].each do |member|
      real_name = member["real_name"]
      status_emoji = member["profile"]["status_emoji"]
      status_text = member["profile"]["status_text"]
      slack_id = member["id"]
      name = member["name"]
      new_user = User.new(real_name: real_name, status_text: status_text, status_emoji: status_emoji, slack_id: slack_id, name: name)
      all_user_array << new_user
    end
    return all_user_array
  end


end