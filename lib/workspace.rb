require_relative 'channel'
require_relative 'user'


class Workspace

  attr_reader :users, :channels

  def initialize
    @users = User.list_all
    @channels = Channel.list_all

  end

  def select_user
    raise NotImplementedError, "Code this method."
  end

  def select_channel
    raise NotImplementedError, "Code this method."
  end

  def show_details
    raise NotImplementedError, "Code this method." 
  end

  def send_message
    raise NotImplementedError, "Code this method."
  end

end
