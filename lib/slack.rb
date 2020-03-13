#!/usr/bin/env ruby
require_relative 'workspace'

def list_users(workspace)
  workspace.users.each do |user|
    user.details
  end
end

def list_channels(workspace)
  workspace.channels.each do |channel|
    channel.details
  end
end


def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  user_option = ""

  until user_option == "quit"
    puts "Choose an option
    - list users
    - list channels
    - select user
    - select channel
    - details
    - quit"
    print "=> "
    user_option = gets.chomp

    case user_option
    when "list users"
      list_users(workspace)
    when "list channels"
      list_channels(workspace)
    when "select user"
      puts "Input user ID or Name"
      print "=> "
      workspace.select_user(gets.chomp)
    when "select channel"
      puts "Input channel ID or Name"
      print "=> "
      workspace.select_channel(gets.chomp)
    when "details"
      if workspace.selected.nil?
        puts "Sorry, you have nothing selected"
      else
        puts "Here are your for #{workspace.selected}"
        workspace.selected.details
      end
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME