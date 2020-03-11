require_relative 'recipient.rb'

class User < Recipient
  attr_reader :slack_id, :real_name, :status_text, :status_emoji, :name
  def initialize(slack_id)
    @slack_id = slack_id
    
  end

  def details
  end

  def self.list_all
  end

end