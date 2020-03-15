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
    select("channel", input)
  end

  def select_user(input)
    select("user", input)
  end

  # helper method for select_channel and select_user
  def select(type, input)
    instance_variable_get("@#{type}s").each do |item|
      if item.slack_id.upcase == input.upcase || item.name.upcase == input.upcase
        @selected = item
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