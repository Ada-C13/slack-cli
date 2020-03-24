require_relative "conversation"

module Slack
  class DirectMessage < Conversation
    
    def initialize(data)
      super(data)
      @user = data["user"]
    end


    # CLASS METHODS
    # Method takes raw Channel data and converts it into an array of Channel objects.
    def self.list_all
      direct_messages = super.map { |data| DirectMessage.new(data)}
    end

    private

    # Method uses http get to retrieve all Channel "objects"
    # returns an array of Channels
    def self.get_all
      query = {
        token: SLACK_TOKEN,
        types: "im",
      }
      return super["channels"] #Slack considers direct messages to also be "channels"
    end
  end
end