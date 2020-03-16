require "httparty"
require "dotenv"
require_relative "user"
require_relative "channel"

Dotenv.load

class Workspace

  attr_reader :channels, :users, :selected

  def initialize
    @channels = Channel.list_all
    @users = User.list_all
    @selected = ""
  end

  def select_channel(channel_name)
    @channels.each do |channel|
      if channel.name == channel_name || channel.slack_id == channel_name
        @selected = channel
        puts "\n You have selected #{channel.name}"
        break
      else
        @selected = nil
      end
    end
    if @selected == nil
      puts "The channel you just entered is not valid!!"
    end
  end

  def select_user(user_name)
    @users.each do |user|
      if user.real_name == user_name || user.slack_id == user_name
        @selected = user
        puts "\n You have selected #{user.real_name}"
        break
      else
        @selected = nil
      end
    end
    
    if @selected == nil
      puts "The user you just entered is not valid!!!"
    end
  end

  def show_details
    if @selected.class == Channel
      return "Channel name = #{@selected.name}, topic = #{@selected.topic}, memeber count = #{@selected.memeber_count}, slack id = #{@selected.slack_id}"
    elsif 
      @selected.class == User
      return "Class name = #{@selected.real_name}, name = #{@selected.name}, slack id = #{@selected.slack_id}"
    end 
  end

  def send_message(message)
    response = @selected.send_message(message)
    return response.code == 200 && response.parsed_response["ok"]
  end 

  def get_conversation_his
    response = @selected.check_conversation_his
    return response.code == 200 && response.parsed_response["ok"]
  end
end