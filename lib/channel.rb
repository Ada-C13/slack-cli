require_relative 'recipient'

module SlackCli
  class Channel < Recipient
    attr_accessor :topic, :member_count

    def initialize(id, handle, topic, member_count)
      super(id, handle)
      @topic = topic
      @member_count = member_count
    end #initialize
  end #class
end #module

testchannel = SlackCli::Channel.new(1, "kate", "coffee", 2)
puts testchannel.topic