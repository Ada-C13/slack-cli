#!/usr/bin/env ruby
require "dotenv"
require "table_print"

Dotenv.load

require_relative "workspace"

#user of program will see this menu
def menu
  puts "Menu"
  puts "1. List Channels"
  puts "2. List Users"
  puts "3. Select User"
  puts "4. Select Channel"
  puts "5. Send Message"
  puts "6. Quit"
end

# all the user interface
def main
  puts "Welcome to the Ada Slack CLI!"
  # sets and instance of workplace and makes it an instance variable
  @workspace = Workspace.new
  # i is set to negative -1
  # as long a user of the program doesn't chose to "quit" the program will countine to run thru the while loop
  # i will then become 1 which is more than 1 and will end the program

  ### need to rescue the Invalid Response error
  i = -1
  while i < 0
    menu
    puts "Your workspace has #{@workspace.channels.length} channels and #{@workspace.users.length} users."
    puts "--------------------"
    puts "Please make a menu selection. You selection by number of keywords"
    answer = gets.chomp.downcase

    # menu options aarray
    choice = ["1", "list channels", "2", "user channels", "3", "select_user", "4", "5", "select_channel", "6", "quit"]

    # this block handles errors of user input and resuces them so the program is not completely exited
    begin
      if !choice.include?(answer)
        raise StandardError.new "This exception will be rescued!"
      end
    rescue StandardError => exception
      p exception.message
    end
    if answer == "list channels" || answer == "1"
      # puts workspace.list_channels (method that shows channels)
      tp workspace.channels, :name, :topic, :member_count
    elsif answer == "list users" || answer == "2"
      # puts workspace.list_users table from user.rb
      tp @workspace.users, :slack_id, :real_name, :name
    elsif answer == "select user" || answer == "3"
      # puts workspace.list_users
      puts "Please select a user by name or slack_id to send a message"
      selection = gets.chomp
      @workspace.select_user(selection)
      details = @workspace.show_details
      # confrims user selection
      puts "You've selected user: #{@workspace.selected.name}"
      puts details
    elsif answer == "select channel" || answer == "4"
      # puts workspace.list_users
      puts "Please select a Channel by name or slack_id to send a message"
      selection = gets.chomp
      @workspace.select_channel(selection)
      details = @workspace.show_details
      puts "You've selected channel: #{@workspace.selected.name}"
      puts details
    elsif answer == "send message" || answer == "5"
      puts "Please enter your message here to #{@workspace.selected.name}"
      message = gets.chomp
      @workspace.send_message(message)
    elsif answer == "quit" || answer == "6"
      i = 1
    end #if loop
  end #while loop
  puts "Thank you for using the Ada Slack CLI"
end # main

main if __FILE__ == $PROGRAM_NAME
