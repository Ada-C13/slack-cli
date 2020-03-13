#!/usr/bin/env ruby
require_relative 'workspace'
require_relative 'user'
require_relative 'channel'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackApi::Workspace.new

   # TODO project

  # interaction with command line
  # list the users, the channels or quit

  puts "What would you like to do?"
  

  puts workspace.list_all_users
  puts workspace.list_all_channels

  

 




  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

