#!/usr/bin/env ruby
require "table_print"
require_relative "workspace"

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts "Your workspace has #{workspace.channels.length} channels and #{workspace.users.length} users."

  i = -1
  while i < 0
    puts
    puts "What would you like to do? Enter the number of your choice.\n"
    puts " 1: list channels \n 2: list users \n 3: select channel \n 4: select user \n 5: show selected recipient's details \n 6: quit"
    puts "----------"
    answer = gets.chomp.downcase
    case answer
      when "1"
        tp workspace.channels, "slack_id", "name", "member_count", "topic"
      when "2"
        tp workspace.users, "slack_id", "name", "real_name", "status_text", "status_emoji"
      when "3"
        # select channel instance
      when "4"
        # select user instance
      when "5"
        # show details of selected recipient
      when "6"
        i = 1
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
