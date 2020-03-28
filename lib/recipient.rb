require 'httparty'
require 'dotenv'

Dotenv.load


module SlackApi
  class Recipient 
    attr_reader :slack_id, :name


    def initialize(
      slack_id:,
      name:

    )
      @slack_id = slack_id
      @name = name

    end 

      def show_details
        raise NotImplementedError, "Define this method in a child class"
      end


      # ################## Class Methods #########################

      # These methods are not implemented ########################
      BASE_URL = "https://slack.com/api/"


      def self.get(url, params)
        # send message using HTTParty
        # check for errors
      end


      # What is a 'factory' method???
      def self.list_all
        raise NotImplementedError, "Define this method in a child class"
      end





      def self.send_message(message, channel)

      #   endpoint = BASE_URL + "chat.postMessage"

      #   response = HTTParty.post(
      #     endpoint,
      #     body: { 
      #       token: BOT_TOKEN, 
      #       text: message, 
      #       channel: channel
      #     },
      #     headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
      #   )

      #   unless response.code == 200 && response.parsed_response["ok"]
      #     raise SlackApiError, "Error when posting #{message} to #{channel}, error: #{response.parsed_response["error"]}"
      #   end

      #   return true

        
      end
  end 

end 


class SlackApiError < StandardError; end
