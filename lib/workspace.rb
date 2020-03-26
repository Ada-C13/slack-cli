require_relative "user"
require_relative "channel"
require_relative "recipient"

class Workspace
  attr_reader :users, :channels, :selected

  def initialize()
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_channel(search_term)
    channels.each do |channel|
      if channel.name.downcase == search_term.downcase || channel.slack_id.downcase == search_term.downcase
        @selected = channel
        return "Okay, #{selected.name} has been selected" 
      end
    end

    # Nice job on the clear personalized error messages. 
    @selected = nil
    return "Sorry, I couldn't find that channel."
  end

  def select_user(search_term)
    users.each do |user|
      if user.name.downcase == search_term.downcase || user.slack_id.downcase == search_term.downcase
        @selected = user
        return "Okay, #{selected.name} has been selected" 
      end
    end

    @selected = nil
    return "Sorry, I couldn't find that user."
  end

  def show_details
    @selected.details
  end

  def send_message(msg_text)
    @selected.send_message(msg_text)
  end
end