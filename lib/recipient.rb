
require 'httparty'
require 'dotenv'
Dotenv.load


BASE_URL = 'https://slack.com/api/'
PRAMS = {
  token: ENV['SLACK_TOKEN'],
  pretty: 1
}

class Recipient

  # add private attributes or methods if needed

  attr_reader :slack_id, :name
  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  # # implemented

  # def send_message(message)
  # end

  def self.get(url, params)
    # Build and send the request
    response = HTTParty.get(@url, query: @params)

    # # Check for errors
    # if response.code != 200 || response["OK"] == false
    #   raise SlackApiError, "API call failed with code #{response.code} and reason '#{response['error']}"
    # end

    # # Turn the raw JSON data into instances of this class
    
    # # passes = response['response'].map do |pass|
    #   self.new(pass['risetime'], pass['duration'])
    # # end

    # # return passes
    # return self.new(response['id'], response['name'])

  end

  # # abstract

  # def details
  #   return "ID: #{slack_id}, nickname: #{name}" 
  # end

  def self.list_all
    # abstract method
  end

end