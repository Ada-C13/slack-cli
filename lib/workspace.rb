class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_channel
    user_input = gets.chomp.upcase
    @channels.each do |channel|
      if channel.name.upcase == user_input || channel.slack_id.upcase == user_input
        @selected = channel
        return "#{@selected.name} is now selected."
      end
    end
  end

  def select_user

  end

  

end