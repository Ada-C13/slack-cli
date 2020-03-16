#!/usr/bin/env ruby

require 'table_print'
require 'dotenv'
require 'httparty'

Dotenv.load
puts ENV

require_relative 'workspace.rb'
require_relative 'receiver.rb'
require_relative 'channel.rb'
require_relative 'user.rb'

module SlackCLI
  def self.main

    puts "Welcome to the Ada Slack CLI!\n\n"
    workspace = SlackCLI::Workspace.new

    puts "The Ada Slack CLI can do several things:\n
    1. List users\n
    2. Choose user\n
    3. List channel\n
    4. Choose channel\n
    5. Summary\n
    6. Send message\n
    7. Exit program\n\n"

    puts "Please enter the number entry you'd like to execute:"

    input = gets.chomp.to_i
    while input != 7 do
      case input
      when 1 
        puts "The users of this program are:\n"
        tp workspace.expose_users, "real name", "username", "name" 
        break
      when 2 
        puts "Enter a username to send your message to:\n"
        puts workspace.choose_user
      when 3 
        puts "The channels of this program are:\n"
        tp workspace.channels, "name", "username", "focus", "headcount"
        break
      when 4 
        puts "Enter a channel name to post your message to:\n"
        puts workspace.choose_channel
      when 5 
        until workspace.chosen != nil
          puts "Please enter a username or channel name."
          input = gets.chomp.to_i 
          puts input.summary 
        end 
      when 6 
        puts "Enter the message you'd like to send here:\n\n" 
        body_talk = gets.chomp
      else 
        puts "Hmm, I might have the memory of a goldfish; I don't remember that option being listed. Try again now?\n\n"
        input = gets.chomp.to_i 
      end 
    end 

    if input == 7
      puts "Thank you for using the Ada Slack CLI\n\n"
    end 
  end
  puts "$PROGRAM_NAME"
  puts $PROGRAM_NAME
  main if __FILE__ == $PROGRAM_NAME 
end 