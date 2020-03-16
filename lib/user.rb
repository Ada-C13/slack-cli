require_relative "recipient"

class User < Recipient
  attr :real_name, :status_text, :status_emoji

  def initialize(real_name:, status_text:, status_emoji:, name:, slack_id:)
    super(slack_id: slack_id, name: name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
  end 

  # ----- CLASS METHODS -----

  def self.list_all
  end 
  
end 