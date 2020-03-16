# !/usr/bin/env ruby
require_relative 'workspace'
require_relative 'user'
require_relative 'channel'
require 'table_print'

def main
  puts "*****************************"
  puts "Welcome to the Ada Slack CLI!"
  puts "*****************************"
  @workspace = Workspace.new
  num_channels = @workspace.channels.length
  num_users = @workspace.users.length
  
  puts "Here are some details about your slack workspace:"
  puts "\nYour workspace has #{num_channels} channels, and #{num_users} users." 
  
  # display options
  user_choice = display_and_get_choice
  
  # get and execute choice
  until user_choice == "quit" 
    execute_choice(user_choice)
    user_choice = display_and_get_choice    
  end
  
  puts "Leaving so soon?  Make sure you wash your hands!"
  puts "Thank you for using the Ada Slack CLI"
end


def display_and_get_choice
  puts "\n***************************"
  puts "What would you like to do?"
  puts "***************************"
  print "Options: List Users, List Channels, Select User, Select Channel, Display Details, Send Message, Quit ==> "
  user_choice = gets.chomp.downcase
  
  return valid_choice?(user_choice)
end


def valid_choice?(user_choice)
  valid_choice = ["channels", "details", "display", "display details", "exit", "lc", "list channels", "list users", "lu", "message", "quit", "q", "select channel", "select user", "send message", "users"]
  until valid_choice.include? user_choice
    puts "#{user_choice.capitalize} is not a command I can execute..."
    puts "You can enter: List Users, List Channels, Select User, Select Channel, Display Details, Send Message, Quit."
    print "So what'll it be? ==> "
    user_choice = gets.chomp.downcase
  end
  return user_wants_to(user_choice)
end


def user_wants_to(choice)
  case choice
  when "users", "list users", "lu"
    return "users"
  when "channels", "list channels", "lc"
    return "channels"
  when "details", "list details", "display details", "display"
    return "details"
  when "select user"
    return "select user"
  when "select channel"
    return "select channel"
  when "message", "send message"
    return "message"
  when "quit", "q", "exit"
    return "quit"
  end
end


def execute_choice(user_choice)
  if user_choice == "users"
    puts "Here's a list of the users currently in your workspace:"
    tp.set User, :slack_id, :name, :real_name, :status_text, :status_emoji
    tp User.list_users
    
  elsif user_choice == "channels"
    puts "Here's a list of the channels currently in your workspace:"
    tp.set Channel, :slack_id, :name, :topic, :member_count
    tp Channel.list_channels
    
  elsif user_choice == "select user"
    print "Which user do you want to select? ==> "
    user_for_details = gets.chomp
    if @workspace.select_user(user_for_details) == []
      puts "\n(!) There is no user with the name or slack ID #{user_for_details}."
    else 
      puts "You got it!  #{@workspace.selected.name} is now selected"
    end
    
  elsif user_choice == "select channel"
    print "Which channel do you want to select? ==> "
    channel_for_details = gets.chomp
    if @workspace.select_channel(channel_for_details) == []
      puts "\n(!) There is no channel with the name or slack ID #{channel_for_details}."
    else 
      puts "You got it!  #{@workspace.selected.name} is now selected"
    end
    
  elsif user_choice == "details"
    if @workspace.show_details == []
      puts "\n(!) There is not a currently selected user or channel.  \n(!) Please first select the user or channel you would like details about by typing 'select user' or 'select channel'."
    else
      puts "\nHere are your selection's details: \n#{@workspace.show_details}"
    end
    
  elsif user_choice == "message"
    if @workspace == nil
      puts "\n(!) There is not a currently selected user or channel to send a message to!  \n(!) Please first select the user or channel you would like to send a message to by typing 'select user' or 'select channel'."
    else 
      puts "Enter the message you would like to send to #{@workspace.selected.name} ==> "
      user_message = gets.chomp
      @workspace.send_message(user_message)
    end
    
  end
end


main if __FILE__ == $PROGRAM_NAME