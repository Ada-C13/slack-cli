#!/usr/bin/env ruby
require 'httparty'
require_relative 'workspace'

#module Slack
  def main
    puts "Welcome to the Ada Slack CLI!"
    workspace = Workspace.new
    # TODO project
    puts "Your workspace has #{workspace.num_of_channels} channels."
    
    puts "Your workspace has #{workspace.num_of_users} users."
    
    options(workspace)

    puts "Thank you for using the Ada Slack CLI"

  end

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
      workspace.list_users  #why wont this work? tp workspace.users, "slack_id", "name", "real_name" 
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

    when "quit"
      return
    end
  end



#end


main if __FILE__ == $PROGRAM_NAME