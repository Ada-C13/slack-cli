#!/usr/bin/env ruby
require_relative "workspace"
require_relative "user"

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts "+++++++++++++++++++++++++++++"
  puts "Your workspace has #{workspace.users.count} users."
  puts workspace.list_users

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME