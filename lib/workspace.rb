
class Workspace
  attr_reader :users, :channels
  attr_accessor :selected

  def initialize
    @users = []
    @channels = []
    @selected = nil 
  end

  def select_user(id: nil, username: nil)
    if id
      @selected = @users.find{|user|user.slack_id == id}
    elsif username
      @selected = @users.find{|user|user.name == name}
    else
      raise ArgumentError, 'SLACK ID or username is required'
    end

    return @selected
  end

  def select_channel(id: nil, name: nil)
    if id
      @selected = @channels.find{|channel|channel.slack_id == id}
    elsif name
      @selected = @channels.find{|channel|channel.name == name}
    else
      raise ArgumentError, 'SLACK ID or channel name is required'
    end

    return @selected
  end


  # def send_message
  #   if @selected is a channel
  #     @selected.send_message #but channel#send_message needs argument??
  #   elsif @selected is a users
  #     @selected.send_message #but channel#send_message needs argument??
  #   end
  # end
end