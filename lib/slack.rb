#!/usr/bin/env ruby
require "table_print"
require_relative "workspace"

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  i = -1
  while i < 0
    # puts "Your workspace has #{num_channels} channels and #{num_users} users."
    puts "--------------------"
    puts "What would you like to do? 'list channels', 'list users', or 'quit'"
    answer = gets.chomp.downcase
    if answer == "list channels"
      tp workspace.channels
    elsif answer == "list users"
      tp workspace.users, "slack_id", "name", "real_name", "status_text", "status_emoji"
    elsif answer == "quit"
      i = 1
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
