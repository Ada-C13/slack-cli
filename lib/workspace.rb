module SlackCLI
	class Workspace

		attr_reader :users, :channels

		def initialize
			@users = User.load_all
			@channels = Channel.load_all
		end

	end
end