require_relative "user"
require_relative "channel"

module SlackCLI

	class Workspace

		attr_reader :users, :channels, :selected

		def initialize
			@users = SlackCLI::User.load_all
			@channels = SlackCLI::Channel.load_all
			@selected = nil
		end

		def select_user(search)
			@users.each do |user|
				if /^U[A-Z0-9]{8}$/.match(search.upcase) && user.slack_id.upcase == search.upcase
					@selected = user
				elsif user.username.upcase == search.upcase
					@selected = user
				end
			end
			
			puts "No such user found based on ID." if @selected == nil
		end
		
		def select_channel(search)
			@channels.each do |channel|
				if /^C[A-Z0-9]{8}$/.match(search.upcase) && channel.slack_id.upcase == search.upcase
					@selected = channel
				elsif channel.name.upcase == search.upcase
					@selected = channel
				end
			end
			
			puts "No such user found based on ID." if @selected == nil
		end

	end

end