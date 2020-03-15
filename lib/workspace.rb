require_relative 'channel.rb'
require_relative 'user.rb'


class Workspace
  attr_reader :users, :channels, :selected_user, :selected_channel
  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected_channel = nil
    @selected_user = nil
  end

  def select_user(inputted_user_info)
    search_by_name = @users.find{ |user| user.name == inputted_user_info}

    search_by_id = @users.find{ |user| user.slack_id == inputted_user_info}

    if search_by_name != nil
      @selected_user = search_by_name
    elsif search_by_id != nil
      @selected_user = search_by_id
    else
      puts "Sorry, that's not a valid username or slack ID"
    end
  
    return @selected_user
  end


def select_channel(inputted_channel_info)
  search_by_name = @channels.find{ |channel| channel.name == inputted_channel_info}

  search_by_id = @channels.find{ |channel| channel.slack_id == inputted_channel_info}

  if search_by_name != nil
    @selected_channel = search_by_name
  elsif search_by_id != nil
    @selected_channel = search_by_id
  else
    puts "Sorry, that's not a valid channel name or slack ID"
  end

  return @selected_channel
end


end