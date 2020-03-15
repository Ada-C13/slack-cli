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

  options_message = "Please choose from the following options:\nlist users, list channels, select user, select channel, details, send message, or quit"

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
    when "details"
      if workspace.selected == nil
        puts "None selected. Please select user or channel"
      else
        workspace.show_details
      end
    when "send message"
      if workspace.selected == nil
        puts "None selected. Please select user or channel"
      else
        puts "Please enter message:"
        text = gets.chomp
        workspace.send_message(text)
        puts "Message sent"
      end
    end
    puts options_message
    input = gets.chomp.downcase
  end

  puts "Thank you for using the Ada Slack CLI!"
end

# Ruby uses __FILE__ to hold the current source file name
main if __FILE__ == $PROGRAM_NAME
