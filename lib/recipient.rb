require "httparty"
require 'dotenv'

Dotenv.load

class Recipient
  
  attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end

  def send_message(text)
  end

  def details
  end


# =====Class methods=====

# gets url, based off of API documentation
 def self.get(url)
  # send message using HTTParty
  response = HTTParty.get(url, query: {token: ENV['SLACK_TOKEN']})

  # accounting for errors
  # slack still gives 200 code
  if response.code != 200 || response["ok"] == false
    raise SlackAPIError, "We encountered a problem: #{response["error"]}"
  end

  return response
 end

 def self.list_all
 end

end


class SlackAPIError < Exception
end
