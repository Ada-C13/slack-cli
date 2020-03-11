require 'httparty'
require_relative 'slack_api_error'


class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end


  def send_message(message)
  end


  def self.get(url, params)
    response = HTTParty.get(url, query: params)

    if response.code != 200 || response["ok"] != true
      raise SlackAPIError, "API call failed with code #{response.code} and reason '#{response["error"]}"
    end

    return response
  end

  #### abstract methods below ######

  def get_details
    raise NotImplementedError, "TODO: Implement me in a subclass!"
  end


  def self.list_all
    raise NotImplementedError, "TODO: Implement me in a subclass!"
  end
end



# message = "testing 7,8,9"
# url = "https://slack.com/api/chat.postMessage"
# SLACK_TOKEN = ENV["SLACK_TOKEN"]

# query_param = {
#   token: SLACK_TOKEN,
#   channel: "CV5S4LJPN",
#   text: message
# }
# # response = HTTParty.get(USERS_URI, query: {token: SLACK_TOKEN})
# # puts response
# sending = HTTParty.get(url, query: query_param)
# puts sending


