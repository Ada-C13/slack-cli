#!/usr/bin/env ruby

require 'dotenv'
require 'httparty'
require 'table_print'

require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new
  puts "#{ workspace.channels.length } channels loaded.."
  puts "#{ workspace.users.length } users loaded.."
  
  continue = true
  until continue == false
    puts "What would you like to do ?\n1. List users\n2. List channels\n3. Select user\n4. Select channel\n5. Details\n6. Quit"
    choice = gets.chomp.downcase

    if ["1", "list users"].include?(choice)
      puts "*"
      tp workspace.users, :username
      puts "*"

    elsif ["2", "list channels"].include?(choice)
      puts "*"
      tp workspace.channels, :name
      puts "*"

    elsif ["3", "select user"].include?(choice)
      puts "What USER would you like to select?"
      workspace.select_user(gets.chomp)
      puts "Selected user: #{ workspace.selected.username }"

    elsif ["4", "select channel"].include?(choice)
      puts "What CHANNEL would you like to select?"
      workspace.select_channel(gets.chomp)
      puts "Selected channel: #{ workspace.selected.name }"

    elsif ["5", "details"].include?(choice)
      continue = false

    elsif ["6", "quit", "q"].include?(choice)
      continue = false
      
    else
      puts "Please choice an option above."
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME