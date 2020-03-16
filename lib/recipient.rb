require 'httparty'

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



    # https://api.slack.com/methods/chat.postMessage
      def send_message(message)
        # use HTTParty here to send the message
        # address errors
      end

      def show_details
        raise NotImplementedError, "Define this method in a child class"
      end


      # ################## Class Methods #########################
      def self.get(url, params)
        # send message using HTTParty
        # check for errors
      end


      # What is a 'factory' method???
      def self.list_all
        raise NotImplementedError, "Define this method in a child class"
      end
  end 

end 


class SlackError < StandardError
end









