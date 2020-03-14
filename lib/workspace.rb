require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels, :selected
  
  def initialize
    user_response = User.get("https://slack.com/api/users.list")
    channel_response = User.get("https://slack.com/api/channels.list")

    @users = []

    user_response["members"].each do |member|
      real_name = member["real_name"]
      status_emoji = member["profile"]["status_emoji"]
      status_text = member["profile"]["status_text"]
      new_user = User.new(real_name: real_name, status_text: status_text, status_emoji: status_emoji)
      @users << new_user
    end

    @channels = []

    channel_response["channels"].each do |channel|
      topic = channel["topic"]
      member_count = channel["num_members"]
      new_channel = Channel.new(topic: topic, member_count: member_count)
      @channels << new_channel
    end

    @selected = selected
  end

  def select_channel
  end

  def select_user
  end

  def show_details
  end

  def send_message
  end
end
