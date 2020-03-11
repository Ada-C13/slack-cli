require_relative "user"
require_relative "channel"

require 'table_print'

module SlackCLI

	class Workspace

		attr_reader :users, :channels, :selected

		def initialize
			@users = SlackCLI::User.load_all
			@channels = SlackCLI::Channel.load_all
			@selected = nil
		end

		# Finds a user based on slack ID or username.
		def select_user(search)
			@users.each do |user|
				if /^U[A-Z0-9]{8}$/.match(search.upcase) && user.slack_id.upcase == search.upcase
					@selected = user
				elsif user.name.upcase == search.upcase
					@selected = user
				else
					@selected == nil
				end
			end
			
			puts "No such user found based on ID." if @selected == nil
		end
		
		# Finds a channel based on channel ID or channel name.
		def select_channel(search)
			@channels.each do |channel|
				if /^C[A-Z0-9]{8}$/.match(search.upcase) && channel.slack_id.upcase == search.upcase
					@selected = channel
				elsif channel.name.upcase == search.upcase
					@selected = channel
				else
					@selected == nil
				end
			end
			
			puts "No such user found based on ID." if @selected == nil
		end

		# Finds details of the object currently selected.
		def show_details
			if @selected != nil
				return @selected
			else
				puts "Nothing has been selected to show details."
			end
		end

		# def send_message
		# 	if @selected != nil
		# 		puts "What message would you like to send to the selected user/channel?"
		# 	end
		# end

	end

end