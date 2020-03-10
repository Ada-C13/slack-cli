require_relative "recipient"

module SlackCLI
	class Channel < Recipient

		attr_reader :name, :topic, :member_count, :slack_id
		
		def initialize(name, topic, member_count)
			super(slack_id)
			@name = name
			@topic = topic
			@member_count = member_count
		end

	end
end