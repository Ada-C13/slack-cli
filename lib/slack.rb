#!/usr/bin/env ruby
require_relative "workspace"

require "table_print"
require "dotenv"
require "httparty"

Dotenv.load

# User: I should see information about how many channels and users were loaded

# User: I should then be given three options for how to interact with the program: list users, list channels, quit

# User: As a user who is at the program's input prompt...

# User: When I type list users, I should see a list of all the users in the Slack workspace. This list should include username, real name, and Slack ID.

# User: When I type list channels, I should see a list of all the channels for that workspace. This list should include the channel's name, topic, member count, and Slack ID.

# User: When I type quit, the program should exit.

# User: After completing any command other than quit, the program should reprint the list of commands and ask for another input.

def menu_choice
  print "Your options include: 1) list users, 2) list channels, or 3) quit: \n"
  print "What would you like to do?"
  return gets.chomp.downcase
end

def main
  workspace = Workspace.new

  puts "\n Welcome to Nora's Slack API CLI. This Slack workspace currently has #{workspace.users.length} users and #{workspace.channels.length} channels."
  action = menu_choice

  until action == "quit" || 3 || "exit" || "3) quit"
    case action
    when "list users" || "users" || 1 || "1) list users"
      tp workspace.users, "name", "real_name", "slack_id"
      puts "\n"
    when "list channels" || "channels" || 2 || "2) list channels"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
      puts "\n"
    else
      puts "Oops! I didn't understand you. Try again?"
      puts "\n"
    end

    action
  end

  puts "Thank you for using Nora's Slack CLI.\n"
end


# The slack.rb file should not create, call, or use the User, Channel, or Recipient classes at all. The slack.rb file should mainly be interacting with the instance of Workspace created in the line workspace = Workspace.new. All User-related information that slack.rb receives should be returned from calling a method defined in the Workspace class.

main if __FILE__ == $PROGRAM_NAME
