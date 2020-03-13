require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels, :selected
  
  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_user(id)
    # TODO: think about using reduce
    found = users.find do |user|
      user.name == id || user.slack_id == id
    end

    if found.nil?
      puts "\nUser not found"
      return nil
    else
      @selected = found
      @selected.details
      return @selected
    end
  end

  def select_channel(id)
    # TODO: think about using reduce
    found = channels.find do |channel|
      channel.name == id || channel.slack_id == id
    end

    if found.nil?
      puts "\nChannel not found"
      return nil
    else
      @selected = found
      @selected.details
      return @selected
    end
  end
end