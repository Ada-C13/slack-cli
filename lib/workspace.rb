require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels
  attr_accessor :selected
  
  def initialize

    @users = User.list_all

    @channels = Channel.list_all

    @selected = selected
  end

  def select_channel
  end

  def select_user(user)
    @users.each do |user_obj|
      if user_obj.name == user || user_obj.slack_id == user
        @selected = user_obj
        return user_obj 
      end
    end
    return "User not found!"
  end

  def show_details
  end

  def send_message
  end
end