require_relative 'recipient.rb'

module SlackCLI
  class Channel < Recipient
    attr_reader :name, :topic, :member_count, :slack_id

    def initialize(name, topic, member_count, slack_id)
      super(slack_id)
      @name = name
      @topic = topic
      @member_count = member_count
    end

    def self.load_all 
      response = SlackCLI::Recipient.get_response("channels.list")
      all_channels = []
      response["channels"].each do |channel|
        name = channel["name"]
        topic = channel["topic"]["value"]
        member_count = channel["member_count"]
        slack_id = channel["id"]

        all_channels << SlackCLI::Channel.new(name, topic, member_count, slack_id)
      end
      return all_channels
    end
  end
end