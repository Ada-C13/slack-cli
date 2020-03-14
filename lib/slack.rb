require "httparty"
require "dotenv"
require "table_print"

require_relative "workspace"
require_relative "user"
require_relative "channel"

# Tell dotenv to look for the .env file
Dotenv.load # from root folder?

# how to test?
def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Slack::Workspace.new

  options_message = "Please choose from the following options:\nlist users, list channels, or quit"

  puts options_message
  input = gets.chomp.downcase

  until input == "quit"
    case input
    when "list users"
      tp workspace.users, "slack_id", "name", "real_name"
    when "list channels"
      tp workspace.channels, "slack_id", "name", "topic", "member_count"
    end
    puts options_message
    input = gets.chomp.downcase
  end

  puts "Thank you for using the Ada Slack CLI!"
end

# Ruby uses __FILE__ to hold the current source file name. A prepended $ on a variable's name indicates a global variable.
main if __FILE__ == $PROGRAM_NAME

# Objective
# We will write a complete command-line application that interacts with Slack. This application will be able to:

# List users and channels
# See details about a user or channel
# Send a message to a user or channel

# All User-related information that slack.rb receives should be returned from calling a method defined in the Workspace class.

# Wave 1 - Listing Channels and Users
# As CLI user, $ ruby lib/slack.rb...

# I should see how many channels and users were loaded
# three options:
# list users
# list channels
# quit

# input prompt:

# When I type list users, I should see a list of all the users in the Slack workspace. list should include username, real name, and Slack ID.
# When I type list channels, I should see a list of all the channels for that workspace. list should include the channel's name, topic, member count, and Slack ID.
# When I type quit, the program should exit.
# After completing any command other than quit, the program should reprint the list of commands and ask for another input.
# Hint: You may want to investigate the Table Print gem to handle formatting tables.
