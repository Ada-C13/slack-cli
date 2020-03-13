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
    
    options

    puts "Thank you for using the Ada Slack CLI"

  end

  def options
    puts "What would you like to do? Please type one of the following:\n- list users\n- list channels\n- select user\n- select channel\n- details\n- quit"
    user_input = gets.chomp.downcase
    valid_inputs = ["list users", "list channels", "select user", "select channel", "details", "quit"]

    until valid_inputs.include?(user_input)
      puts "Please type a valid response :\n- list users\n- list channels\n- select user\n- select channel\n- details\n- quit"
      user_input = gets.chomp.downcase
    end

    case user_input
    when "list users"
      workspace = Workspace.new  #how do i get my code so i dont need this?
      workspace.list_users(workspace)
      options
    when "list channels"
      workspace = Workspace.new
      workspace.list_channels(workspace)
      options
    when "select user"
      user_info = Workspace.new.name_or_id("user")
    when "select channel"
      channel_info = Workspace.new.name_or_id("channel")
    when "details"
    when "quit"
      return
    end
  end



#end


main if __FILE__ == $PROGRAM_NAME