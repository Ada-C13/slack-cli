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

  # Check results
  def self.check_results(result)
    unless result.code == 200
      raise RuntimeError, "Cannot talk to slack. HTTP code: #{result.code}"
    end
    
    unless result["ok"]
      raise RuntimeError, "Cannot talk to slack. Result is not ok."
    end
  end
  
  # Method to send a message
  def send_message(message)
    query_parameters = { token: TOKEN, channel: @id, text: message }
    result = HTTParty.post(SLACK_URL + "chat.postMessage", query: query_parameters)
    self.check_results(result)
    return result
  end # def send_message

  # Method to get all recipients
  def self.get(method)
    query_parameters = { token: TOKEN }
    result = HTTParty.get(SLACK_URL + method, query: query_parameters)
    self.check_results(result)
    return result
  end # def self.get

  def details
    # No details here, define in sub-class
  end

  def self.list_all
    # No list_all here, define in sub-class
  end

end # Class
