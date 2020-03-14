#!/usr/bin/env ruby
require 'httparty'
require 'table_print'
require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  puts "Your workspace has #{workspace.num_of_channels} channels."
  puts "Your workspace has #{workspace.num_of_users} users."
  
  options(workspace)

  puts "Thank you for using the Ada Slack CLI"
end

# @TODO: Refactor to make this not recursive.  Nice to have,
#        but not required. 
def options(workspace)
  puts "What would you like to do? Please type one of the following:\n- list users\n- list channels\n- select user\n- select channel\n- details\n- quit"
  user_input = gets.chomp.downcase
  valid_inputs = ["list users", "list channels", "select user", "select channel", "details", "quit"]

  until valid_inputs.include?(user_input)
    puts "Please type a valid response :\n- list users\n- list channels\n- select user\n- select channel\n- details\n- quit"
    user_input = gets.chomp.downcase
  end

  case user_input
    when "list users"
     # @TODO why does this not work     tp workspace.users, "slack_id", "name", "real_name" 
      workspace.list_users  
      options(workspace)
    when "list channels"
      workspace.list_channels
      options(workspace)
    when "select user"
      user_info = workspace.name_or_id("user")
      options(workspace)
    when "select channel"
      channel_info = workspace.name_or_id("channel")
      options(workspace)
    when "details"
      # if workspace.selected_recipient.class == User
      #   puts workspace.selected_recipient.name
      #   puts workspace.selected_recipient.real_name
      #   puts workspace.selected_recipient.id
      # elsif workspace.selected_recipient.class == Channel
      #   puts selected_recipient.channel["topic"]["value"]
      #   puts selected_recipient.channel["num_members"]
      #   puts selected_recipient.channel["id"]
      # end
      
    when "quit"
      return
  end
end





main if __FILE__ == $PROGRAM_NAME