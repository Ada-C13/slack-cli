
require 'dotenv'
require 'httparty'

Dotenv.load

BASE_URL = "https://slack.com/api/users.list"
SLACK_ID = ENV["SLACK_TOKEN"]

class User
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(real_name:, status_text:, status_emoji:)

  end

  

  def details(each)
  #
  end

  def self.list_all(each)
  #
  end
end