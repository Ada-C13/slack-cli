#!/usr/bin/env ruby
require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts "#{ workspace.channels.length } channels loaded.."
  puts "#{ workspace.users.length } users loaded.."
  puts "What would you like to do ?"
  
  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME