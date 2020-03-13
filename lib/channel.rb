require_relative 'recipient'

module SlackCli
  class Channel < Recipient
    attr_reader :member_count, :topic

    def initialize(slack_id:,name:,member_count:,topic:)
      super(slack_id,name)
      @member_count = member_count
      @topic = topic 
    end

  

    def self.list_all
      data = self.get("#{BASE_URL}conversations.list")

      channels = []

      data["channels"].each do |channel|
        channels << Channel.new(
          slack_id: channel["id"], 
          name: channel["name"], 
          member_count:channel["num_members"], 
          topic:channel["topic"]["value"]
        )
      end 

      return channels 
    end 

  
  end
end