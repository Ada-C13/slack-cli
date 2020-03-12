require 'dotenv'
require 'httparty'
require 'awesome_print'
require_relative 'recipient'


Dotenv.load

class Channel < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  BASE_URL = "https://slack.com/api/channels.list?"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]


  def initialize

  

  end


  def self.list_all

  query = {
    token: SLACK_TOKEN, 
  }
  
  response = HTTParty.get(BASE_URL, query: query)

    response["channels"].each do |channel|
    ap channel["name"]
    end
  end
 
end

puts Channel.list_all