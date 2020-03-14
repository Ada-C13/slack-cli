require_relative 'slack_api_error'
require 'httparty'


module SlackCLI
  class Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id = "", name = "")
      @slack_id = slack_id
      @name = name
    end

    
    def send_message(message)
      post_uri = "https://slack.com/api/chat.postMessage"

      query_params = {
        body: {
          token: ENV["SLACK_TOKEN"],
          channel: @slack_id || @name,
          text: message
        },
        headers:{
          "Content-Type": "application/x-www-form-urlencoded"
        }
      }

      response = HTTParty.post(post_uri, query_params)

      if response.code != 200 || response["ok"] != true
        raise SlackAPIError.new "Error when posting #{message} to #{@name}, error: #{response["error"]}"
      end

      return true
    end


    def self.get(url, params)
      response = HTTParty.get(url, query: params)

      if response.code != 200 || response["ok"] != true
        raise SlackAPIError, "Oops! API call failed: '#{response["error"]}"
      end

      return response
    end

    ### abstract methods below ###
    def get_details
      raise NotImplementedError, "TODO: Implement me in a subclass!"
    end


    def self.list_all
      raise NotImplementedError, "TODO: Implement me in a subclass!"
    end
  end
end
