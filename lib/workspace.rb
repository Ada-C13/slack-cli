require_relative 'user'
require_relative 'channel'

module SlackCLI

  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = User.list_all
      @channels = Channel.list_all
      @selected = nil 
    end

    def select_user
      puts "To select user, please enter a Slack ID or username:"
      user_input = gets.chomp
      assign_selected(find_recipient(user_input))
      puts "Okay, #{selected.name} has been selected"  # inspired by Devin(dHelmgren)
    end

    def select_channel
      puts "To select channel, please enter a Slack ID or name:"
      user_input = gets.chomp
      assign_selected(find_recipient(user_input))
      puts "Okay, #{selected.name} has been selected"  # inspired by Devin(dHelmgren)
    end

    def send_message
      raise ArgumentError, "There is not yet a selected recipient" if @selected == nil
      puts "Enter the message you want to send out:"
      user_input = gets.chomp
      @selected.send_message(user_input)
    end

    def show_details
      raise ArgumentError, "There is not yet a selected recipient" if @selected == nil
      @selected.get_details
      return true
    end

    def show_history
      raise ArgumentError, "There is not yet a selected recipient" if @selected == nil
      @selected.get_message_history
      return true
    end

    def find_recipient(id_name)
      channel_found = @channels.find{|channel|channel.slack_id == id_name || channel.name == id_name }
      user_found = @users.find{|user|user.slack_id == id_name || user.name == id_name}
      found_recipient = nil

      if channel_found != nil
        found_recipient = channel_found
      elsif user_found != nil
        found_recipient = user_found
      else
        raise ArgumentError, 'Recipient not found. A valid Slack ID or username is required.'
      end

      return found_recipient
    end

    def assign_selected(recipient_instance)
      @selected = recipient_instance
    end
  end
end


##select_user or #select_channel when taking in argument
# def select_user(id_name)
#   user_found = @users.find{|channel|channel.slack_id == id_name || channel.name == id_name}
#   
#   raise ArgumentError, 'A valid SLACK ID or username is required' if user_found == nil
#  
#   return @selected = user_found
# end