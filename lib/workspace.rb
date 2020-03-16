require_relative "lib_helper.rb"
class Workspace

  attr_reader :users, :channels
  def initialize
    @users = User.get_list("user")
    @channels = Channel.get_list("channel")
  end

 
end