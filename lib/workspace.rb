require 'table_print'
require_relative 'user'
require_relative 'channel'
require_relative 'slack_api_error'

module SlackCLI

  class Workspace
    attr_reader :users, :channels
    attr_accessor :selected

    def initialize
      @users = User.list_all
      @channels = Channel.list_all
      @selected = nil 
    end

    def select_user
      puts "To select user, please enter a Slack ID or username:"
      user_input = gets.chomp
      assign_selected(find_recipient(user_input))
    end

    def select_channel
      puts "To select channel, please enter a Slack ID or name:"
      user_input = gets.chomp
      assign_selected(find_recipient(user_input))
    end

    def send_message
      raise ArgumentError, "There is not yet a selected recipient" if @selected == nil
      puts "Enter the message you want to send out:"
      user_input = gets.chomp
      @selected.send_message(user_input)
    end

    def show_details
      @selected.get_details
      return true
    end

    def find_recipient(id_name)
      channel_found = @channels.find{|channel|channel.slack_id == id_name || channel.name == id_name }
      user_found = @users.find{|channel|channel.slack_id == id_name || channel.name == id_name}
      found_recipient = nil

      if channel_found != nil
        found_recipient = channel_found
      elsif user_found != nil
        found_recipient = user_found
      else
        raise ArgumentError, 'A valid SLACK ID or username is required'
      end

      return found_recipient
    end

    def assign_selected(recipient_instance)
      @selected = recipient_instance
    end
  end
end

# def select_user(id_name)
#   found_by_id = @users.find{|user|user.slack_id == id_name}
#   found_by_name = @users.find{|user|user.name == id_name}

#   if found_by_id != nil
#     @selected = found_by_id
#   elsif found_by_name != nil
#     @selected = found_by_name
#   else
#     raise ArgumentError, 'A valid SLACK ID or username is required'
#   end

#   return @selected
# end

# #methods without parameters, I could prompt user gets.chomp inside the method. But is that right? How to test?

# def select_channel(id_name)
#   found_by_id = @channels.find{|channel|channel.slack_id == id_name}
#   found_by_name = @channels.find{|channel|channel.name == id_name}

#   if found_by_id != nil
#     @selected = found_by_id
#   elsif found_by_name != nil
#     @selected = found_by_name
#   else
#     raise ArgumentError, 'A valid SLACK ID or username is required'
#   end

#   return @selected
# end

  # def list_users
  #   tp @users, :slack_id, :name, :real_name
  #   return true
  # end

  # def list_channels
  #   tp @channels, :slack_id, :name, :topic, :member_count
  #   return true
  # end

  # def select_user(id: nil, username: nil)
  #   if id
  #     @selected = @users.find{|user|user.slack_id == id}
  #   elsif username
  #     @selected = @users.find{|user|user.name == username}
  #   else
  #     raise ArgumentError, 'SLACK ID or username is required'
  #   end

  #   return @selected
  # end

  # def send_message
  #   if @selected is a channel
  #     @selected.send_message #but channel#send_message needs argument??
  #   elsif @selected is a users
  #     @selected.send_message #but channel#send_message needs argument??
  #   end
  # end

# testspace = Workspace.new
# testspace.send_message("what what")