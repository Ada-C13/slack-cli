class Recipient

	attr_reader :slack_id
	
	def initialize(slack_id)
		@slack_id = slack_id
	end

end