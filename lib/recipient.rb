require "httparty"
require "dotenv"
Dotenv.load
AUTH_TOKEN = ENV["SLACK_TOKEN"]

class Recipient
  attr_reader :name, :slack_id

  def initialize(name, slack_id)
    @name = name
    @slack_id = slack_id
  end

  private
#???????????????
  def self.get(base_url)
    query = {
      token: AUTH_TOKEN,
    }
    response = HTTParty.get(base_url, query: query)

    return response unless response["okay"] == false
  end

  def self.list_all
    raise(NotImplementedError, "Implement me in a child class!")
  end
end
