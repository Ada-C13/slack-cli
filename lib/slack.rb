#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'table_print'
require 'tty-prompt'

require_relative 'workspace'

Dotenv.load

BASE_URL = "https://slack.com/api/"
KEY = ENV["SLACK_TOKEN"]

def main
  workspace = Slack::Workspace.new
  prompt = TTY::Prompt.new
  continue = true
  # active_selection = nil

  selection = nil

  puts "Welcome to the Ada Slack CLI!\n"

  until continue == nil
    prompt.select("Please make a selection from the following options:") do |menu|
      menu.choice 'list users', -> {
        tp workspace.users, "id", "name", "real_name"
      }
      menu.choice'list channels', -> {
        tp workspace.channels, "id", "name", "topic", "num_members"
      }
      menu.choice 'select user', -> {
        tp workspace.users, "id", "name", "real_name"
        puts "Please enter the name or id of the user you would like to select:"
        user_selection = gets.chomp.to_s
        selection = workspace.select_user(user_selection)
      }
      menu.choice 'select channel', -> {
        tp workspace.channels, "id", "name", "topic", "num_members"
        puts "Please enter the name or id of the channel you would like to select:"
        user_selection = gets.chomp.to_s
        selection = workspace.select_channel(user_selection)
      }
      menu.choice 'send message', -> {
        if selection == nil
          puts "There is no recipient selected. Please select a channel or user first."
        else
          puts "Please enter the message you would like to send"
          message = gets.chomp.to_s
          selection.send_message(message)
        end
      }
      menu.choice 'details', -> {
        if selection == nil
          puts "There is no recipient selected. Please select a channel or user first."
        else
          selection.details
        end
      }
      menu.choice 'quit', -> {
        continue = nil
      }
    end
  end

    puts "\nThank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME