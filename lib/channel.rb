
require 'dotenv'
require 'httparty'

class User

  Dotenv.load

  BASE_URL = "https://slack.com/api/conversations.list"
  SLACK_ID = ENV["SLACK_TOKEN"]
  
  def details(each)
  #
  end

  def self.list_all
  #
  end
end