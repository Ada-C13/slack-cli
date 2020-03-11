class Workspace

  attr_reader :users, :channels

  def initialize
    @users = [] # arrays of users
    @channels = [] # arrays of channels
  end

end