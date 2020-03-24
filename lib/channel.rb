require_relative "conversation.rb"

module Slack
  class Channel < Conversation
    attr_reader :id, :name, :topic, :member_count
    
    def initialize(channel)
      raise ArgumentError, "Trying to create Channel object with bad data: #{channel}." if channel["id"] == nil || !(channel["is_channel"])  
      super(channel)
      @name = channel["name"]
      @topic = channel["topic"]["value"]
      @member_count = channel["num_members"]
    end

    # def details
    #   # return string describing: 
    #   # channel name
    #   # channel topic 
    #   # member_count 
    # end


  # Method takes raw Channel data and converts it into an array of Channel objects.
    def self.list_all
      channels = super.map { |channel| Channel.new(channel)}
    end

    private

      # Method uses http get to retrieve all Channel "objects"
      # returns an array of Channels
    def self.get_all
      return super["channels"]
    end

  end
end