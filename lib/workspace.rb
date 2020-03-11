module SlackCLI
	class Workspace

		attr_reader :users, :channels

		def initialize
			@users = []
			@channels = []

			@users = User.load_all
		end

	end
end