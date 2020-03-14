require_relative "recipient"

#module Slack 

  class Channel < Recipient

    attr_reader :topic, :member_count

    def initialize( topic:, member_count:, name:, slack_id:)
      super(slack_id: slack_id, name: name)
      @topic = topic
      @member_count = member_count
    end

    # def num_of_channels
    #   number = @channels["channels"].count
    #   return number
    # end

    # def list_channels
    #   i = 1
    #   channels["channels"].each do |channel|
    #    puts "Channel number #{i}'s name is #{channel["name"]}, their topic is '#{channel["topic"]["value"]}', it has #{channel["num_members"]} members and its id is #{channel["id"]}."
    #    i += 1
    #   end
    # end

    def details
    end

    #------ Class Methods ------

    #api endpoint https://api.slack.com/methods/conversations.list
    def self.list_all
    end

  end
#end