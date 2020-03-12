require 'httparty'
require 'dotenv'
require 'pry'
require 'table_print'

Dotenv.load

class SearchError < StandardError; end

class Recipient
  attr_reader :name,:id

  CHANNEL_URL = 'https://slack.com/api/channels.list'
  MEMBER_URL = 'https://slack.com/api/users.list'
  TOKEN = ENV['SLACK_TOKEN']

  def initialize(name,id)
    @name = name
    @id = id
  end

  def self.get_recipients(url)
    query_parameters = {
      token: TOKEN
    }

    response = HTTParty.get(url, query: query_parameters)
    if !response["ok"] || response["ok"] == "ok"
      raise SearchError, "Unable to retrieve info through API: #{response["error"]}"
    end

    return response
  end

  def send_message
    puts "What message would you like to send?"
    message = gets.chomp
  
    query_parameters = {
      token: TOKEN,
      channel: @id,
      text: message
    }
    
    response = HTTParty.post(MESSAGE_URL,query: query_parameters)
  end
end