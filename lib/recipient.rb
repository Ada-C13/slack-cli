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
  
  def valid_name
    
  end
  
  def valid_slack_id
    
  end
  
  # def send_message(message)
  
  # end
  
  
  # class method that builds a URL to send with GET HTTParty
  # invoked in workspace initialize
  # this is where API calls will happen in child classes  
  # TODO:  Add test w/ bad sub_url
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

