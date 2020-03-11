require_relative 'recipient.rb'
require 'dotenv'
require 'httparty'

Dotenv.load

class Channel < Recipient
  attr_reader :slack_id, :topic, :member_count, :name
  def initialize(slack_id)
    @slack_id = slack_id
    
  end

  def details
  end

  def self.list_all
    url = "https://slack.com/api/channels.list"
    params = {
        token: ENV['SLACK_TOKEN'],
      }
      response = self.get(url,params)
    return response['channels'].map{ |channel| channel["name"]}

  end 

end