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
    puts "What would you like to do? Please type one of the following:\n-1- list users\n-2- list channels\n-6- quit"
    user_input = gets.chomp.downcase
    valid_inputs = ["list users", "list channels", "quit"]

    until valid_inputs.include?(user_input)
      puts "Please type a valid response :\n- list users\n- list channels\n- quit"
      user_input = gets.chomp.downcase
    end

    case user_input
    when "list users", 1
      workspace = Workspace.new  #how do i get my code so i dont need this?
      workspace.list_users(workspace)
      options
    when "list channels", 2
      workspace = Workspace.new
      workspace.list_channels(workspace)
      options

    when "quit", 6
      return
    end
  end
#end


main if __FILE__ == $PROGRAM_NAME