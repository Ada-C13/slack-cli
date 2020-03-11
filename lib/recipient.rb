require 'HTTParty'

class Recipient
  attr_reader :slack_id, :name
  def initialize(slack_id)
    @slack_id = slack_id
    @name = ""
  end

  def send_message(message)
  end

  def self.get(url,params)
    response = HTTParty.get(url,query: params)
    return response
  end

  def details
    #should be implemented in child class
  end

  def self.list_all
    #should be implemented in child class
  end

end