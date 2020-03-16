require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def find_recipient(list_all:, name: nil, slack_id: nil)
    raise ArgumentError unless name || slack_id
    return list_all.find do |recipient| 
      name ? recipient.name == name : recipient.slack_id == slack_id  
    end 
  end

  def select_user (name: nil, slack_id: nil)
    @selected = find_recipient list_all: users, name: name, slack_id: slack_id
  end

  def select_channel (name: nil, slack_id: nil)
    @selected = find_recipient list_all: channels, name: name, slack_id: slack_id
  end

  def show_selected
    puts selected ? selected.details : "To view the details of a user or channel please make that selection."
  end

  def send_message
    if selected
      puts "\nType your message for #{selected.name} and press Enter to send."
      message = gets.chomp
      raise Recipient::SlackAPIError if message.empty?
      selected.send_message(message)
    else
      puts "\nNo recipient selected"
    end
  end
end