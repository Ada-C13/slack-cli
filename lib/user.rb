require_relative 'recipient.rb'
require 'dotenv'
require 'httparty'

Dotenv.load

class User < Recipient
  attr_reader :slack_id, :real_name, :status_text, :status_emoji, :name
  def initialize(slack_id)
    @slack_id = slack_id
    
  end

  def details
  end

  def self.list_all
    url = "https://slack.com/api/users.list"
    params = {
        token: ENV['SLACK_TOKEN'],
      }
      response = self.get(url,params)
      array_of_info = []
      response["members"].each do |user|
        array_of_info.push({
          username: user["name"],
          real_name: user["real_name"],
          slack_id: user["id"]
        })
      end

    return array_of_info
  end

end