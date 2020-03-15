require 'httparty'
require 'awesome_print'
#require 'dotenv'

class Recipient
  attr_reader :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end

  # fetcher method based on the API's docs
  def self.get(url)
    #send message using HTTParty
    response = HTTParty.get(url, query: {token: ENV['SLACK_TOKEN']})

    #check for errors
    if response.code != 200 || response["ok"] == false
      raise SlackAPIError, "We encountered a problem: #{response["error"]}"
    end
    return response
  end

  def self.list_all
    raise NotImplementedError, "Define this method in a child class"
  end

end

# This will be common to all the other files in the program
# so I'm including it here, where it will be accessible to each other class.
class SlackAPIError < Exception
end