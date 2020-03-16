
class Workspace

  attr_reader :users, :channels, :selected

  def initialize(users: [], channels: [])
    @users = users
    @channels = channels 
    @selected = nil
  end 

end 