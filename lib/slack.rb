#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'table_print'
require_relative 'workspace'

def main
  workspace = SlackCli::Workspace.new
  puts "Welcome to the Ada Slack CLI!"
  puts "Here are the options:"
  options = ["list users", "list channels", "select user", "quit"]
  options.each do |option|
    puts option
  end
  
  user_input = gets.chomp.downcase
  while user_input != options[-1] #quit
    if user_input == options[0] #list users
      #GET user details- username, real name, and Slack ID.
      tp workspace.users, :id, :name, :real_name #https://github.com/arches/table_print usage
    elsif user_input == options[1] #list channels
      #GET channel details- name, topic, member count, and Slack ID
      tp workspace.channels, :id, :name, :topic, :member_count
    #userinput equals option--select user
    elsif user_input == options[2] #select user
      #prompt: "which user do you want to select"
      puts "Which user do you want to select?"
      #present list of users
      tp workspace.users, :id, :name, :real_name
      #user input...gets chomp 
      user_input = gets.chomp

      valid_inputs = workspace.valid_inputs_id_names
    
      #check is user's input includes anything in this valid_inputs[]
      while !valid_inputs.include?(user_input)
        #if not, ask to reenter
        puts "Invalid. Enter selection again. Try copy and pasting SlackID or username."
        user_input = gets.chomp
      end

      #find user
      found_user = workspace.find_user(user_input)
      #assign the user found to selected
      workspace.selected = found_user
     
      #prompt"enter "details" if you want more info"

    end 
    user_input = gets.chomp
  end
  
  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end #main

main if __FILE__ == $PROGRAM_NAME