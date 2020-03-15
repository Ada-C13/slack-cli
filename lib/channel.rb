require_relative 'recipient'

module Slack
  class Channel < Recipient

    attr_reader :name, :topic, :num_members, :id

    def initialize(id, name, topic, num_members)

      super(id, name)

      @topic = topic ||= "No topic"
      @num_members = num_members

    end

    def details
      tp self, "id", "name", "topic", "num_members"
    end

    def self.load_all
      query_results = HTTParty.get(BASE_URL + "channels.list", query: {token: KEY})
      channel_list = query_results["channels"].to_a.map {
        |channel| Channel.new(channel["id"], channel["name"], channel["topic"["value"]], channel["members"].length)
      }
      return channel_list
    end

    def send_message(message)
      if message.class != String
        raise ArgumentError.new("Message: #{message} must be a string!")
      else
        HTTParty.post(BASE_URL + "chat.postMessage", query: {token: KEY, channel: @id, text: message})
      end
    end

  end
end