require 'dotenv'
require 'httparty'
require_relative 'recipient'

Dotenv.load

class Channel < Recipient

  TOKEN        = ENV["SLACK_API_TOKEN"]
  SLACK_URL_CL = "https://slack.com/api/conversations.list"

  # Generator
  attr_reader :id, :name, :topic, :member_count

  # Constructor
  def initialize(id, name, topic, member_count)
    @id    = id
    @name  = name
    @topic = topic
    @member_count = member_count
  end

  # Return details for a channel
  def details
    return "ID = #{@id}, name = #{@name}, topic = #{@topic}, member_count = #{@member_count}"
  end

  # Get channels from slack
  def self.list_all
    query_parameters = { token: TOKEN }
    result = HTTParty.get(SLACK_URL_CL, query: query_parameters)

    unless result.code == 200
      raise RuntimeError, "Cannot talk to slack. HTTP code: #{result.code}"
    end
    
    unless result["ok"]
      raise RuntimeError, "Cannot talk to slack. Result is not ok."
    end

    channels = []
    result["channels"].each do |channel|
      id           = channel["id"]
      name         = channel["name"]
      topic        = channel["topic"]["value"]
      member_count = channel["num_members"]
      channels << Channel.new(id, name, topic, member_count)
    end
    return channels

  end

end # Class
