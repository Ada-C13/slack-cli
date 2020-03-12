require 'dotenv'
require 'httparty'

Dotenv.load

SLACK_TOKEN = ENV['SLACK_TOKEN']


class Recipient
  attr_reader :slack_id, :name
  
  
  def initialize(slack_id, name)
    #self.class.validate_id(id) <== this is what was in CSV record
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
  # whole thing: "https://slack.com/api/channels.list?token=#{SLACK_TOKEN}&pretty=1"
  
  def self.get_everything(sub_url)
    url = "https://slack.com/api/#{sub_url}?token=#{SLACK_TOKEN}"
    
    response = HTTParty.get(url)
    
    return response
  end
  
  
  
  # def details
  
  # end
  
  
  
end




