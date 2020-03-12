# !/usr/bin/env ruby
require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  num_channels = workspace.channels.length
  num_users = workspace.users.length
  puts "Here are some details about your slack workspace:"
  puts "Your workspace has #{num_channels} channels, and #{num_users} users."
  
  # display options
  user_choice = display_and_get_choice
  
  # get and execute choice
  until user_choice == "quit" 
    execute_choice(user_choice)
    user_choice = display_and_get_choice    
  end
  
  puts "Leaving so soon?  Have fun out there!"
  puts "Thank you for using the Ada Slack CLI"
end


def display_and_get_choice
  puts "What would you like to do?"
  puts "Options: List Users, List Channels, Quit ==> "
  user_choice = gets.chomp.downcase
  
  return valid_choice?(user_choice)
end


def valid_choice?(user_choice)
  valid_choice = ["users", "channels", "list users", "list channels", "quit", "exit"]
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
  elsif user_choice == "channels"
    # run list channels method
    # list channels could be in workspace
    p "we're looking at the channels"
  elsif user_choice == "quit"
    p "leaving so soon?  see you next time."
    exit
  end
end

main if __FILE__ == $PROGRAM_NAME