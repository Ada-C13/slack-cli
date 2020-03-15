#add formatting gems and requires'
# why not just require_relative 'recipient'
require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels, :selected

  def initialize ()
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def details
    
  end
  def self.list_all
    
  end
end