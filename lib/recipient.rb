require 'httparty'
require 'dotenv'
require 'pry'
require 'table_print'

Dotenv.load

class Recipient
  attr_reader :name,:id

  CHANNEL_URL = 'https://slack.com/api/channels.list'
  MEMBER_URL = 'https://slack.com/api/users.list'
  TOKEN = ENV['SLACK_TOKEN']

  def initialize(name,id)
    @name = name
    @id = id
  end

  def self.get_recipients(url,keyword)
    query_parameters = {
      token: TOKEN
    }

    HTTParty.get(url, query: query_parameters)[keyword]
  end
  
end