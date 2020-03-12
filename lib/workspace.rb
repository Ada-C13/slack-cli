# initialize should not take in any parameters
# instance variables @users and @channels. Set @users to an empty array. Set @channels to an empty array. Eventually, these should be refactored so that they are arrays of users or arrays of channels
# Set attr_reader for these two instance variables in Workspace
# Run $ ruby lib/slack.rb to make sure that the Ruby program runs without syntax errors. If you get an error that says that Workspace is not defined, what line of code do you need to add to the top of lib/slack.rb in order to load another class?
# With your pair, determine: What is the relationship between Workspace and a User? Is it inheritance or composition? Is-a or has-a or has-many? How do we know from the Ruby code?
# With your pair, determine: What is the relationship between Workspace and a Channel? Is it inheritance or composition? Is-a or has-a or has-many? How do we know from the Ruby code?

# Module caused error, slack might need to be inside Module too?
class Workspace
  attr_reader :users, :channels

  def initialize
    @users = []
    @channels = []
    # @selected = ?
  end

#   def select_channel
#   end

end

# We want Workspace to have at least two dependencies: User and Channel
