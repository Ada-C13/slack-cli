require_relative "user"
require_relative "channel"

class Workspace
  attr_reader :users, :channels
  attr_accessor :selected
  
  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = ""
  end

  def select_channel(input)
    @channels.each do |channel|
      if channel.slack_id.upcase == input.upcase || channel.name.upcase == input.upcase
        @selected = channel
        break
      else 
        @selected = ""
      end
    end
  end

  def select_user(input)
    @users.each do |user|
      if user.slack_id.upcase == input.upcase || user.name.upcase == input.upcase
        @selected = user
        break
      else 
        @selected = ""
      end
    end
  end

  def show_details
    return nil if @selected == ""
    return @selected.details
  end

  def send_message
  end
end