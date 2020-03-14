# require gems

class Recipient
  attr_reader :slack_id, :name
  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end

  def send_message
    # how to send message/ what will it return
    # error handling
  end
  def self.get
    # how to get(api lecture)/ what will it return
    # error handling
  end

  def details
    
  end
  def self.list_all
    # error handling
  end
end

class SlackAPIError < Exception
end