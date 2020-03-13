# This is the parent class for User and Channel
require 'httparty'

module SlackApi
  class Recipient # parent class 
    attr_reader :slack_id, :name


    def initialize(
      slack_id:,
      name:

    )
      @slack_id = slack_id
      @name = name

    end # initialize end



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


      # What is a factory method???
      def self.list_all
        raise NotImplementedError, "Define this method in a child class"
      end



  end # class end

end # module end


# This will be common to all the other files in the program.
class SlackAPIError < Exception
end









