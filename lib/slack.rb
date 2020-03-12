#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'table_print'
require_relative 'workspace'

def main
  workspace = SlackCli::Workspace.new
  puts "Welcome to the Ada Slack CLI!"
  puts "Here are the options:"
  options = ["list users", "list channels", "quit"]
  options.each do |option|
    puts option
  end
  
  user_input = gets.chomp.downcase
  while user_input != options[-1]
    if user_input == options[0]
      #list users with username, real name, and Slack ID.
      tp workspace.users, :id, :name, :real_name #https://github.com/arches/table_print usage
    end 
    user_input = gets.chomp
  end
  
  
  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end #main

main if __FILE__ == $PROGRAM_NAME