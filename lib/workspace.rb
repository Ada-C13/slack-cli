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
      if (channel.name) == channel_name
        @selected = channel
      end
    end
  end

  def select_user(user_name)
    @users.each do |user|
      if (user.real_name) == user_name
        @selected = user
      end
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

  def send_message
    HTTParty.post("https://slack.com/api/chat.postMessage", query: { token: ENV["SLACK_API_TOKEN"], channel: @selected  , text: "user_input" })
  end

end