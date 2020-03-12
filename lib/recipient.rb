require 'dotenv'
require 'httparty'

class Recipient
  attr_reader :name, :slack_id

  def initialize(name:, slack_id:)
    @name = name
    @slack_id = slack_id
  end

  
  def send_message(message)
  
  end

  def self.get(uri, params)

  end
  
  def details(each)
    raise NotImplementedError, 'Implement me in a child class!'
  end

  def self.list_all(each)
    raise NotImplementedError, 'Implement me in a child class!'
  end

end