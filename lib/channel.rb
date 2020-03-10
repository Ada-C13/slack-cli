require_relative "recipient"

class Channel < Recipient

	attr_reader :name, :topic, :member_count, :slack_id
	
	def initialize(name, topic, member_count)
		super(slack_id)
		@name =
		@topic =
		@member_count =
	end

end