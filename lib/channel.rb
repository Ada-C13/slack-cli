require_relative "recipient"

module SlackCLI
	class Channel < Recipient

		attr_reader :name, :topic, :member_count, :slack_id
		
		def initialize(name, topic, member_count, slack_id)
			super(slack_id, name)
			@topic = topic
			@member_count = member_count
		end

		# Load all channels.
		def self.load_all
			response = Recipient.get_response("channels.list")
			all_channels = []

			response["channels"].each do |channel|
				name = channel["name"]
				topic = channel["topic"]["value"]
				member_count = channel["members"].length
				slack_id = channel["id"]

				all_channels << SlackCLI::Channel.new(name, topic, member_count, slack_id)
			end

			return all_channels
		end
	end
end