# !/usr/bin/env ruby
require 'table_print'
require 'dotenv'

require_relative 'workspace'

Dotenv.load


def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  puts "This workspace has #{workspace.users.length
  } users and #{workspace.channels.length
  } channels."

  puts "\nPlease selecet what you would like to do from the list below:"

  answers = [
    "list users",
    "list channels",
    "select user",
    "select channel",
    "show details",
    "send message",
    "quit"
  ]

  answer = ""
  while !([7, "quit"].include?(answer)) 
    answers.each_with_index do |answer, i| 
      puts "#{i + 1}. #{answer}" 
    end

    answer = gets.chomp.downcase
  
    until answers.include?(answer) || (1..(answers.length)).to_a.map { |n| n.to_s }.include?(answer)
      puts "Your answer was not valid."
      puts "\nPlease selecet what you would like to do from the list below:"
      answers.each_with_index do |answer, i| 
        puts "#{i + 1}. #{answer}" 
      end
      answer = gets.chomp
    end

    case answer
      when "1", "list users" 
        puts "\nhere is a list of users:"
        tp workspace.users, :slack_id , :nickname, :real_name
      when "2", "list channels"
        puts "\nhere is a list of channels:"
        tp workspace.channels, :slack_id , :nickname, :topic, :member_count
      when "3", "select user"
        puts "\nhere is a list of users:"
        tp workspace.users, :slack_id , :nickname, :real_name
        puts "what is the user id of your selected user?"
        user_id = gets.chomp.upcase
        workspace.select_user(user_id)
        puts "\nyou selected \"#{workspace.selected.nickname}\"\n"
      when "4", "select channel"
        puts "\nhere is a list of channels:"
        tp workspace.channels, :slack_id , :nickname, :topic, :member_count
        puts "what is the channel id of your selected channel?"
        channel_id = gets.chomp.upcase
        workspace.select_channel(channel_id)
        puts "\nyou selected \"#{workspace.selected.nickname}\"\n"
      when "5", "show details"
        if workspace.selected == ""
          puts "\nThere is no user or channel selected yet."
        else
          puts workspace.show_details
        end
      when "6", "send message"
        puts "What message would you like to send?"
        message = gets.chomp
        workspace.send_message(message)

      when "7", "quit"
        puts "\nThank you for using the Ada Slack CLI\n\n"
        exit
    end

    if answer != "quit"
      puts "\nWhat would you like to do now?"
    end
  
  end
end

main if __FILE__ == $PROGRAM_NAME