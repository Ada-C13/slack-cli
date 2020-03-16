require_relative "channel"
require_relative "user"

class WorkSpace
  attr_reader :users, :channels, :selected
  
  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_channel(search_term)
    
    channels.each do |channel|
      if channel.name == search_term || channel.slack_id.downcase == search_term
        @selected = channel
        return "Okay, #{selected.name} has been selected" 
      end
    end

    @selected = nil
    return "Sorry, I couldn't find that channel."
  end

  def select_user(search_term)

    users.each do |user|
      if user.name == search_term || user.slack_id.downcase == search_term
        @selected = user
        return "Okay, #{selected.name} has been selected" 
      end
    end
    @selected = nil
    return "Sorry, I couldn't find that user"
  end


  def show_details
    @selected.details
  end

  def send_message(msg)
    @selected.send_message(msg)
  end
end
  