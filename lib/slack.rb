#!/usr/bin/env ruby
require_relative "workspace"

# User: I should see information about how many channels and users were loaded

# User: I should then be given three options for how to interact with the program: list users, list channels, quit

# User: As a user who is at the program's input prompt...

# User: When I type list users, I should see a list of all the users in the Slack workspace. This list should include username, real name, and Slack ID.

# User: When I type list channels, I should see a list of all the channels for that workspace. This list should include the channel's name, topic, member count, and Slack ID.

# User: When I type quit, the program should exit.

# User: After completing any command other than quit, the program should reprint the list of commands and ask for another input.

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end


# The slack.rb file should not create, call, or use the User, Channel, or Recipient classes at all. The slack.rb file should mainly be interacting with the instance of Workspace created in the line workspace = Workspace.new. All User-related information that slack.rb receives should be returned from calling a method defined in the Workspace class.

main if __FILE__ == $PROGRAM_NAME
