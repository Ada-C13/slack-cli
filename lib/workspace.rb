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
        return "#{@selected.name} is now selected."
      end
    end

    @selected = nil
    return "Sorry, I couldn't find a channel matching \"#{search_word}.\""
  end

  def select_user
  end
end
