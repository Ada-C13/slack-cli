require_relative "user"
require_relative "channel"

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_channel(search_word)
    user_input = search_word.upcase
    @channels.each do |channel|
      if channel.name.upcase == user_input || channel.slack_id.upcase == user_input
        @selected = channel
        return "Thanks, #{@selected.name} is now selected."
      end
    end

    @selected = nil
    return "Sorry, I couldn't find a channel matching \"#{search_word}.\""
  end

  def select_user(search_word)
    user_input = search_word.upcase
    @users.each do |user|
      if user.name.upcase == user_input || user.slack_id.upcase == user_input
        @selected = user
        return "Thanks, #{@selected.name} is now selected."
      end
    end

    @selected = nil
    return "Sorry, I couldn't find a user matching \"#{search_word}.\""
  end

  def show_details
    if @selected != nil
      @selected.details
    else
      return "No user or channel was selected."
    end
  end

  def send_message
  end
end
