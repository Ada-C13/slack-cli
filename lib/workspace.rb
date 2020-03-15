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
    found = users.find do |user|
      user.name == id || user.slack_id == id
    end

    if found.nil?
      puts "\nUser not found"
      return nil
    else
      puts "You've selected the user: #{found.name}"
      @selected = found
    end
  end

  def select_channel(id)
    found = channels.find do |channel|
      channel.name == id || channel.slack_id == id
    end

    if found.nil?
      puts "\nChannel not found"
      return nil
    else
      puts "\nYou've selected the channel: #{found.name}"
      @selected = found
    end
  end

  def show_details
    selected.details
  end

  def new_message(message)
    return selected.send_message(message)
  end
end