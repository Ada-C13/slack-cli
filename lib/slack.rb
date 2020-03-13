# !/usr/bin/env ruby
require_relative 'workspace'

def main
  # display welcome
  welcome 
  
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


def welcome 
  puts "*****************************"
  puts "Welcome to the Ada Slack CLI!"
  puts "*****************************"
  workspace = Workspace.new
  num_channels = workspace.channels.length
  num_users = workspace.users.length

  puts "Here are some details about your slack workspace:"
  puts "\nYour workspace has #{num_channels} channels, and #{num_users} users."
end


def display_and_get_choice
  puts "\n***************************"
  puts "What would you like to do?"
  puts "***************************"
  print "Options: List Users, List Channels, Select User, Select Channel, Display Details, Quit ==> "
  user_choice = gets.chomp.downcase
  
  return valid_choice?(user_choice)
end


def valid_choice?(user_choice)
  valid_choice = ["channels", "details", "display", "display details", "exit", "list channels", "list users", "quit", "select channel", "select user", "users"]
  until valid_choice.include? user_choice
    puts "That doesn't look like a valid choice..."
    puts "You can enter: list users, list channels, or quit."
    print "So what'll it be? ==> "
    user_choice = gets.chomp.downcase
  end
  return user_wants_to(user_choice)
end


def user_wants_to(choice)
  case choice
  when "users", "list users"
    return "users"
  when "channels", "list channels"
    return "channels"
  when "details", "list details", "display details", "display"
    return "details"
  when "select user"
    return "select user"
  when "select channel"
    return "select channel"
  when "quit", "exit"
    return "quit"
  end
  # add select, details, etc.
end


def execute_choice(user_choice)
  if user_choice == "users"
    # run list users method
    # list users coould be in workspace
    p "we're checking out our users here"
    tp.set User, :slack_id, :name, :real_name, :status_text, :status_emoji
    tp User.list_users
  elsif user_choice == "channels"
    # run list channels method
    # list channels could be in workspace
    p "we're looking at the channels"
    tp.set Channel, :slack_id, :name, :topic, :member_count
    tp Channel.list_channels
  elsif user_choice == "select user"
    # set @selected to that user object
    p "we're gonna have a selected user here!  wow!"
  elsif user_choice == "select channel"
    # set @selected to that channel object
    p "we're gonna have a selected channel here!  wow!"
  elsif user_choice == "details" && @selected.class == User
    # show details of selected user
  elsif user_choice == "details" && @selected.class == Channel
    # show details of selected channel
  end
end

main if __FILE__ == $PROGRAM_NAME