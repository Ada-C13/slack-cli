require_relative "recipient"
require 'httparty'
require 'dotenv'

Dotenv.load

BASE_URL = "https://slack.com/api/conversations.list"

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(real_name:, status_text:, status_emoji:, name:, slack_id:)
    super(slack_id: slack_id, name: name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end






end

  # def details

  # end


  # def self.list_all
  #   users = []
  #   data = self.get("https://slack.com/api/users.list")
 #   data["members"].each do |user|
  