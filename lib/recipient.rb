#both user and channel can inherit 
require 'httparty'
require 'dotenv'

BASE_URL = "https://slack.com/api/"

Dotenv.load

class Recipient 
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name 

  end  

  def details
    #override
  end 

  def self.list_all
    #override
  end 

  def send_message
    #override
  end 
end 

