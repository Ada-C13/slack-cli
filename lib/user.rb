require_relative "recipiant"
require 'httparty'
require 'dotenv'

Dotenv.load

BASE_URL = "https://slack.com/api/conversations.list"

class User < Recipiant
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(real_name, status_text, status_emoji)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji

  end

  def details

  end
  
  def self.list_all

  end

end