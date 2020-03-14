#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'table_print'
require_relative "workspace"

Dotenv.load

def main
  # puts "Welcome to the Ada Slack CLI!"
  # workspace = WorkSpace.new
  # puts "Here you have information about users and chanels"
  # puts "Type users /n , Type chenels/n, Type quit"
  # choice = gets.chomp.downcase

  # while choice  != "quit"
  #   case choice
  #   when "chanels"
  #     puts "do something"
  #   when "chanels"
  #     puts "do something"
  #   when " quite"
  #     brake
  #   end
  # end
 

  # I should see information about how many channels and users were loaded
  # I should then be given three options for how to interact with the program:
  # list users
  # list channels
  # quit
  # As a user who is at the program's input prompt...

  # When I type list users, I should see a list of all the users in the Slack workspace. This list should include username, real name, and Slack ID.
  # When I type list channels, I should see a list of all the channels for that workspace. This list should include the channel's name, topic, member count, and Slack ID.
  # When I type quit, the program should exit.
  # After completing any command other than quit, the program should reprint the list of commands and ask for another input.
  # Hint: You may want to investigate the Table Print gem to handle formatting tables.

  # query_parameters = {token: KEY} 


  # response = HTTParty.get(BASE_URL, query: query_parameters)
  
  # puts "Thank you for using the Ada Slack CLI"
  # puts response

  # response["channels"].each do |chanel|
  #   puts chanel["name"]
  # end



  

end


main if __FILE__ == $PROGRAM_NAME
