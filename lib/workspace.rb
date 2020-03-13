class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.load_all
    @channels = Channel.load_all
  end

  def list_users
    result = ""
    users.each do |user|
      result += user.get_details
      result += "\n"
    end
    return result.chop.chop
  end

  def list_channels
    result = ""
    channels.each do |channel|
      result += channel.get_details
      result += "\n"
    end
    return result.chop.chop
  end


  # def select_user(slack_id:)
  #   selection = nil
  #   users.each do |user|
  #     if user.skack_id == slack_id
  #       user = 
  # end  
end