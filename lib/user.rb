require_relative "recipient"

module SlackCLI
	class User < Recipient

		attr_reader :username, :real_name, :slack_id
		
		def initialize(name, real_name, slack_id)
			super(slack_id, name)
			@real_name = real_name
		end

		def self.load_all
			response = Recipient.get_response("users.list")
			all_users = []

			response["members"].each do |member|
				username = member["name"]
				real_name = member["profile"]["real_name"]
				slack_id = member["id"]

				all_users << SlackCLI::User.new(username, real_name, slack_id)
			end

			return all_users
		end

	end
end