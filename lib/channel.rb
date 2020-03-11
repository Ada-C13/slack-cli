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
      array_of_info = []
      response["channels"].each do |channel|
        array_of_info.push({
          name: channel["name"],
          topic: channel["topic"]["value"],
          member_count: channel["members"].length,
          slack_id: channel["id"]
        })
      end

    return array_of_info
  end 

end