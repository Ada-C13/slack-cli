
require 'httparty'
require 'dotenv'

Dotenv.load

BASE_URL = "https://slack.com/api/conversations.list"

class Recipiant
  attr_reader :slack_id, :name
  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.list_all
    raise NotImplementedError, 'Implement me in a child class!'
  end

  # def send_message(message)

  # end

  # def self.get(url, params)

  # end

  # def details

  # end

end
  
