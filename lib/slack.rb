#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'

require_relative 'workspace.rb'

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new

  def ok_recipient?(requested_recipient)
    if requested_recipient.nil?
      puts "Recipient does not exist"
    else
      puts "Great! Your current recipient is: #{requested_recipient.name}"
      return requested_recipient
    end
  end

  in_use = true

  until in_use == false
    puts "What would you like to do (please enter your selection number here):
    (1) Get a list of channels
    (2) Get a list of users
    (3) Select user
    (4) Select channel
    (5) Show details
    (6) Send message
    (7) Show chat history
    (8) Set reminder
    (9) Quit"

    user_input = gets.chomp.to_i

    if user_input == 1
      tp workspace.channels
    elsif user_input == 2
      tp workspace.users
    elsif user_input == 3
      puts "Can do! Who would you like to send a message to?"
      current_recipient = workspace.select_user(gets.chomp)
      ok_recipient?(current_recipient)
    elsif user_input == 4
      puts "Can do! What channel would you like to send a message to?"
      current_recipient = workspace.select_channel(gets.chomp)
      ok_recipient?(current_recipient)
    elsif user_input == 5
      if workspace.selected.empty? == false
        tp workspace.selected
      else
        puts "No channel or user is currently selected."
      end
    elsif user_input == 6
      if workspace.selected.empty? == false
        puts "A message - lovely! What would you like to say?"
        sent_message = workspace.message_to_outbox(gets.chomp)
        p "Consider it done. Confirmation: #{sent_message}"
      else
        puts "No recipient is currently selected. Please select a user or channel first."
      end
    elsif user_input == 7
      puts workspace.show_history
    elsif user_input == 8
      puts "A reminder it is! What day and time (this year) would you like to set it for?"
      print "Month (as a number):  "
      month_input = gets.chomp.to_i
      print "Day:  "
      day_input = gets.chomp.to_i
      print "Time (in 24 hour format please):  "
      time_input = gets.chomp.to_i
      puts "And what would you like the reminder to say?"
      message_input = gets.chomp
      reminder = workspace.set_reminder(message_input, Time.utc(2020, month_input, day_input, time_input))
      puts "Consider it done. Confirmation >> Reminder set? #{reminder["ok"]}"
    elsif user_input == 9
      puts "Thank you for using the Ada Slack CLI"
      in_use = false
    end
  end
end

main if __FILE__ == $PROGRAM_NAME