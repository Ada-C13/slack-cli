#!/usr/bin/env ruby

require 'dotenv'
require 'httparty'
require 'table_print'

require_relative 'workspace'
require_relative 'channel'
require_relative 'user'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new
  puts "#{ workspace.channels.length } channels loaded.."
  puts "#{ workspace.users.length } users loaded.."
  
  continue = true
  until continue == false
    puts "What would you like to do ?\n1. List users\n2. List channels\n3. Quit"
    choice = gets.chomp.downcase

    if ["1", "list users"].include?(choice)
      puts "*"
      tp workspace.users, :username
      puts "*"
    elsif ["2", "list channels"].include?(choice)
      puts "*"
      tp workspace.channels, :name
      puts "*"
    elsif ["3", "quit", "q"].include?(choice)
      continue = false
    else
      puts "Please choice an option above."
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME