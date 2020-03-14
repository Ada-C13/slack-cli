require_relative "user"
require_relative "channel"

class Workspace
  attr_reader :users, :channels
  attr_writer :selected
  
  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = ""
  end

  def select_channel(input)
    @channels.each do |channel|
      if channel["id"].upcase == input || channel["name"].upcase == input
        @selected = channel
      end
    end

  end

  def select_user
  end

  def show_details
    return @selected.details
  end

  def send_message
  end
end