require_relative "user"
require_relative "channel"
require_relative "recipient"

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
				if user.slack_id.upcase == search.upcase
					@selected = user
				elsif user.name.upcase == search.upcase
					@selected = user
				else
					@selected == nil
				end
			end
			
			raise ArgumentError.new("No such user found based on search.") if @selected == nil
		end
		
		# Finds a channel based on channel ID or channel name.
		def select_channel(search)
			@channels.each do |channel|
				if channel.slack_id.upcase == search.upcase
					@selected = channel
				elsif channel.name.upcase == search.upcase
					@selected = channel
				else
					@selected == nil
				end
			end
			
			raise ArgumentError.new("No such channel found based on search.") if @selected == nil
		end

		# Finds details of the object currently selected.
		def show_details
			if @selected != nil
				return @selected
			else
				raise ArgumentError.new("Nothing has been selected to show details.")
			end
		end

		# Send a message.
		def send_message(message)
			SlackCLI::Recipient.send_message(message, @selected)
		end

	end

end