class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = ""
  end

  def select_channel
    user_input = gets.chomp
    @channels.each do |channel|
      @selected = channel if channel.name == user_input || channel.slack_id == user_input
    end
  end

  def select_user

  end

  

end