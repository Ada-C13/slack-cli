require "httparty"
require "awesome_print"
require "dotenv"
Dotenv.load

module Slack_cli
  class Recipient
    attr_reader :id, :name

      def initialize(id:, name:)
        @id = id
        @name = name
      end
      # Given the URL and params(KEY) get the response from the API. 

      def self.get(url,params)
        resp = HTTParty.get(url, query: params)
        if resp.code == 200 && resp.parsed_response["ok"]
          return resp
        end
        return false
      end

      def self.list_all
        raise NotImplementedError, 'Implement me in a child class!'
      end

      def details
        raise NotImplementedError, 'Implement me in a child class!'
      end
  end
end
# base_url = "https://slack.com/api/"
#     post_url = "#{base_url}channels.list"
#     params = { token: ENV["SLACK_API_TOKEN"] }

# Recipient.get(post_url, params)