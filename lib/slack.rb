#!/usr/bin/env ruby
require "table_print"
require "gemoji-parser"
require_relative "workspace"

def get_selected
  puts "Enter the slack id or name of the channel/user:"
  user_selected = gets.chomp
  return user_selected
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts "Your workspace has #{workspace.channels.length} channels and #{workspace.users.length} users."

  i = -1
  while i < 0
    puts "What would you like to do? (Enter the number.)\n"
    puts " 1: list channels \n 2: list users \n 3: select a channel or user \n 4: show details of selected channel/user \n 5: quit"
    puts "----------"
    answer = gets.chomp.downcase
    case answer
      when "1"
        # table_print all channels
        tp workspace.channels, "slack_id", "name", "member_count", "topic"
      when "2"
        # table_print all users
        tp workspace.users, "slack_id", "name", "real_name", "status_text", "status_emoji"
      when "3"
        # update @selected and confirm with message
        user_input = get_selected
        if workspace.select(user_input)
          selected_recipient = workspace.select(user_input)
          recipient_type = selected_recipient.class == Channel ? "channel" : "user"
          puts "The #{recipient_type} named '#{selected_recipient.name}' is currently selected."
        else
          puts "No matching slack credentials found."
        end
      when "4"
        # show details of selected recipient
        if workspace.selected
            puts workspace.selected.details
        else
          puts "No recipient selected."
        end
      when "5"
        # quit
        i = 1
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME