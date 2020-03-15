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
  puts "What would you like to do? Please type one of the following:\n- list users\n- list channels\n- select user\n- select channel\n- details\n- send message\n- quit"
  user_input = gets.chomp.downcase
  valid_inputs = ["list users", "list channels", "select user", "select channel", "details", "send message", "quit"]

  until valid_inputs.include?(user_input)
    puts "Please type a valid response :\n- list users\n- list channels\n- select user\n- select channel\n- details\n- send message\n- quit"
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
      if workspace.selected_type == "user"   # TODO I think this needs to be broken out in to user and channel
        puts "Username: #{workspace.selected_recipient["name"]}"
        puts "Name: #{workspace.selected_recipient["real_name"]}"
        puts "Id: #{workspace.selected_recipient["id"]}"
      elsif workspace.selected_type == "channel"
        puts "Topic: #{workspace.selected_recipient["topic"]["value"]}"
        puts "Number of Members: #{workspace.selected_recipient["num_members"]}"
        puts "Channel ID: #{workspace.selected_recipient["id"]}"
      else 
        "You have not selected a recipient."
      end
      options(workspace)
    when "send message"
      workspace.send_message_if_selected
      options(workspace)
    when "quit"
      return
  end
end





main if __FILE__ == $PROGRAM_NAME