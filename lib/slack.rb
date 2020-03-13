#!/usr/bin/env ruby
require_relative "workspace"
require_relative "recipient"
require_relative "user"
require_relative "channel"

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts "+++++++++++++++++++++++++++++"
  puts "Your workspace has #{workspace.users.count} users and #{workspace.channels.count} channels."
  puts "+++++++++++++++++++++++++++++"
  puts workspace.list_users
  puts "+++++++++++++++++++++++++++++"
  puts workspace.list_channels

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME