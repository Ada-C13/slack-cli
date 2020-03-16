require_relative "conversation.rb"

module Slack
  class Channel < Conversation
    attr_reader :name, :topic, :member_count
    
    def initialize(channel)
      super(channel)
      @name = 
      @topic = 
      @member_count = 
      @type = :CHANNEL
    end


  # Method uses http get to retrieve all Channel "objects"
  # returns an array of Channels
    def self.get_all
      # HTTP get
      # API endpoint https://slack.com/api/conversations.list default "public_channel" 
    end


  # Method gets results of self.get_all and pretty prints it
    def self.list_all

    end
  end
end