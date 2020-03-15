require_relative "recipient"

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize
    super(name: name, id: id)
    
  end

  
  def details
  end

  #------ Class Methods ------

  #api endpoint https://api.slack.com/methods/conversations.list
  def self.list_all
  end

end