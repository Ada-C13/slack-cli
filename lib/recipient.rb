require "httparty"
require "dotenv"

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  # def send_message(text)
  # end

  # def details
  #   raise NotImplementedError, "Implement in child class??"
  # end

  private

  # class method to build a url to send to HTTParty invoked in workspace initialize
  def self.get_all(sub_url)
    url = "https://slack.com/api/#{sub_url}?token=#{SLACK_TOKEN}"
    response = HTTParty.get(url)

    if response.code != 200 || response["ok"] == false
      raise SlackAPIError, "We encountered a problem: #{response["error"]}"
    end

    return response
  end

  # def self.select
  # end
end

# this will be common to other files in the program
class SlackAPIError < Exception
end