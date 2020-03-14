require 'httparty'

class Recipient
  attr_reader :slack_id, :name
  #parent to channel and user classes
  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.get(url)
    q = {
      token: ENV['TOKEN']
    }
    response = HTTParty.get(url, query: q)

    #check for errors
    if response.code == "ok"
      raise ArgumentError, "#{response["error"]}"
    end
  end

  def send_message(message)
    #do some httparty posting shiz
  end

  def details
  end

  def self.list_all
  end
end

