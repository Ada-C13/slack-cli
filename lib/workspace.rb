class Workspace
  attr_reader :users, :channels
  attr_accessor :selected

  def initialize
    @users = User.load_all
    @channels = Channel.load_all
    @selected = nil
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

  def select_user(query: )
    self.selected = users.select { |user| user.slack_id == query || user.name == query}.first
  end

end