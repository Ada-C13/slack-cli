require 'dotenv'
require 'httparty'
require 'table_print'

Dotenv.load

SLACK_TOKEN = ENV['SLACK_TOKEN']


class Recipient
  attr_reader :slack_id, :name
  
  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end
  
  
  def send_message(message)
    url = "https://slack.com/api/chat.postMessage?token=#{SLACK_TOKEN}&channel=#{@slack_id}&text=#{message}"
    
    response = HTTParty.post(url)
    
    if response["ok"] != true || response.code != 200
      raise SlackAPIError.new(("There was an error posting this message: #{response["error"]}"))
    else puts "Your message was sent successfully!"
    end
    
    return response
  end
  
  
  def self.get_everything(sub_url)
    url = "https://slack.com/api/#{sub_url}?token=#{SLACK_TOKEN}"
    
    response = HTTParty.get(url)
    
    if response["ok"] != true || response.code != 200
      raise SlackAPIError.new("There was an error retrieving information from the Slack API: #{response["error"]}")
    end
    
    return response
  end
  
  
  def details
    return "Slack ID: #{slack_id}, Name: #{name},"
  end
  
end

class SlackAPIError < Exception
end

private

def self.list
  raise NotImplementedError, "Implement me in a child class!"
end