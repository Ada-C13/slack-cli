require_relative "recipient"

class User < Recipient

	attr_reader :username, :real_name, :slack_id
	
	def initialize(username, real_name, slack_id)
		super(slack_id)
		@username = username
		@real_name = real_name
	end

end