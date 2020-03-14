require "httparty"
require "dotenv"
require "table_print"

require_relative "workspace"
require_relative "user"
require_relative "channel"

# Tell dotenv to look for the .env file
Dotenv.load # must run from root folder: ruby lib/slack.rb

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Slack::Workspace.new

  options_message = "Please choose from the following options:\nlist users, list channels, select user, select channel, or quit"

  puts options_message
  input = gets.chomp.downcase

  until input == "quit"
    case input
    when "list users"
      tp workspace.users, "slack_id", "name", "real_name"
    when "list channels"
      tp workspace.channels, "slack_id", "name", "topic", "member_count"
    when "select user"
      puts "Please enter user name or ID:"
      search_term = gets.chomp
      puts workspace.select_user(search_term)
    when "select channel"
      puts "Please enter channel name or ID:"
      search_term = gets.chomp
      puts workspace.select_channel(search_term)
    end
    puts options_message
    input = gets.chomp.downcase
  end

  puts "Thank you for using the Ada Slack CLI!"
end

# Ruby uses __FILE__ to hold the current source file name. A prepended $ on a variable's name indicates a global variable.
main if __FILE__ == $PROGRAM_NAME

#### Wave 2 - Selecting and Showing Details ####

# 3 additional options:

# "select user": select user as the current recipient, with username or Slack ID
# "select channel": select channel as the current recipient, with channel name or Slack ID
# For selecting both users and channels, if no user/channel has that name or ID, the program should let me know and return to the main command loop.
# "details": on the current recipient. information printed depends on whether channel or user. If no recipient currently selected, the program should let me know and return to main command prompt.
