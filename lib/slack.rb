#!/usr/bin/env ruby
require_relative "workspace"

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end


# The slack.rb file should not create, call, or use the User, Channel, or Recipient classes at all. The slack.rb file should mainly be interacting with the instance of Workspace created in the line workspace = Workspace.new. All User-related information that slack.rb receives should be returned from calling a method defined in the Workspace class.

main if __FILE__ == $PROGRAM_NAME
