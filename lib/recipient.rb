class Recipient
  attr_reader :slack_id, :name
  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end
  def send_message
    
  end
  def self.get
    
  end
  def details
    
  end
  def self.list_all

  end
end
class SlackAPIError < Exception
end