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
    @selected = nil
  end

  def select_channel(channel_name)
    @channels.each do |channel|
      if (channel.name) == channel_name
        @selected = channel
        break
      elsif (channel.slack_id) == channel_name
        @selected = channel
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
      if user.real_name == user_name
        @selected = user
        puts "You have selected #{user.real_name}"
        break
      elsif user.slack_id == user_name
        @selected = user
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
    @selected.send_message(message)
=begin
 url = "https://slack.com/api/chat.postMessage"
    if @selected.class == Channel
      HTTParty.post(url , query: {token: ENV["SLACK_API_TOKEN"], channel: @selected.slack_id, text: message})
    elsif @selected.class == User
      HTTParty.post(url , query: {token: ENV["SLACK_API_TOKEN"], channel: @selected.slack_id, text: message})
    end
=end
  end 
end