require 'httparty'
require 'dotenv'
Dotenv.load
require_relative 'recipient'


class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji
  def initialize(real_name:, status_text:, status_emoji:)

    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
    
  end
  
  def self.list_all

    response = User.get("https://slack.com/api/users.list")

    user_output_array = []
   
    response["members"].each do |member|
      user_output = {}
      user_output["Real Name"] = member["real_name"]
      user_output["Username"] = member["name"]
      user_output["Slack ID"] = member["id"]
      user_output_array << user_output
    end
    return user_output_array
  end


end