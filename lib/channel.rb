require 'HTTParty'
require 'dotenv'
require 'table_print'
require_relative 'workspace'
require_relative 'slack'
require_relative 'user'
require_relative 'recipient'

Dotenv.load


class Channel < Recipient

  attr_reader :topic, :member_count, :name, :slack_id
  def initialize(name:, slack_id:, topic:, member_count:)
    super(name, slack_id)
    @topic = topic
    @member_count = member_count 
  end 

  def self.list_all
    data = self.get("https://slack.com/api/channels.list")
    channels = []
    data["channels"].each do |channel|
      channels << self.new(
                name: channel["name"],
                slack_id: channel["id"],
                topic: channel["topic"]["value"], 
                member_count: channel["num_members"]       
      )
    end
    return channels
  end 

end
