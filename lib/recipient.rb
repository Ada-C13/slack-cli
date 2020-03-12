require 'dotenv'
require 'httparty'

Dotenv.load

class Recipient

  TOKEN        = ENV["SLACK_API_TOKEN"]
  SLACK_URL    = "https://slack.com/api/"

  # Generator
  attr_reader :id, :name

  # Constructor
  def initialize(id, name)
    @id   = id
    @name = name
  end

  def send_message(message)

  end

  def self.get(method)
    query_parameters = { token: TOKEN }
    result = HTTParty.get(SLACK_URL + method, query: query_parameters)

    unless result.code == 200
      raise RuntimeError, "Cannot talk to slack. HTTP code: #{result.code}"
    end
    
    unless result["ok"]
      raise RuntimeError, "Cannot talk to slack. Result is not ok."
    end

    return result
  end

  def details
    return "" # No details here, define in sub-class
  end

  def self.list_all
    return [] # No details here, define in sub-class
  end

end # Class
