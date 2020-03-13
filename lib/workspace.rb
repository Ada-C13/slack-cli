require 'dotenv'
require 'httparty'
require_relative 'user'
require_relative 'channel'


class Workspace
  attr_reader :users, :channels, :selected
  
  def initialize
    @users = User.list_users
    @channels = Channel.list_channels
    @selected = nil 
  end
  

  def select_channel(user_channel)
    if channels.find { |channel| channel.name == user_channel } == nil && channels.find { |channel| channel.slack_id == user_channel } == nil
      return []
    elsif 
      @selected = channels.find { |channel| channel.name == user_channel }
    elsif
      @selected = channels.find { |channel| channel.slack_id == user_channel } 
    end
  end
  
  
  def select_user(user_name)
    if users.find { |user|  user.name == user_name } == nil && users.find { |user| user.slack_id == user_name } == nil
      return []
    elsif 
      @selected = users.find { |user| user.name == user_name }
    elsif
      @selected = users.find { |user| user.slack_id == user_name } 
    end
  end
  
  
  def show_details
    if @selected == nil
      return []
    end
    
    return @selected.details
  end
  
  
  # def send_message
  
  # end
  
end

# def self.load_all(full_path: nil, directory: nil, file_name: nil)
#   full_path ||= build_path(directory, file_name)

#   return CSV.read(
#     full_path,
#     headers: true,
#     header_converters: :symbol,
#     converters: :numeric
#   ).map { |record| from_csv(record) }
# end

# private

#   def self.load_all
#   response = Recipient.get_response("channels.list")
#   all_channels = []
#   response["channels"].each do |channel|
#     name = channel["name"]
#     topic = channel["topic"]["value"]
#     member_count = channel["members"].length
#     slack_id = channel["id"]
#     all_channels << SlackCLI::Channel.new(name, topic, member_count, slack_id)
#   end
#   return all_channels
# end