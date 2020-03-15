require "httparty"
require "dotenv"
require "table_print"
require "colorize"

require_relative "workspace"
require_relative "user"
require_relative "channel"

# Tell dotenv to look for the .env file
Dotenv.load # must run from root folder: ruby lib/slack.rb

def main
  puts "Welcome to the Ada Slack CLI!\n".blue
  workspace = Slack::Workspace.new

  options_message = "Please choose from the following options:\n1. list users \n2. list channels \n3. select user \n4. select channel \n5. details \n6. send message \n7. quit\n".blue

  puts options_message
  input = gets.chomp.downcase

  until input == "quit" || input == "7"
    case input
    when "list users", "1"
      tp workspace.users, "slack_id", "name", "real_name"
    when "list channels", "2"
      tp workspace.channels, "slack_id", "name", "topic", "member_count"
    when "select user", "3"
      puts "Please enter user name or ID:".blue
      search_term = gets.chomp
      puts workspace.select_user(search_term)
    when "select channel", "4"
      puts "Please enter channel name or ID:".blue
      search_term = gets.chomp
      puts workspace.select_channel(search_term)
    when "details", "5"
      if workspace.selected == nil
        puts "None selected. Please select user or channel".red
      else
        workspace.show_details
      end
    when "send message", "6"
      if workspace.selected == nil
        puts "None selected. Please select user or channel".red
      else
        puts "Please enter message:".blue
        text = gets.chomp
        workspace.send_message(text)
        puts "Message sent".green
      end
    end
    puts "\n"
    puts options_message
    input = gets.chomp.downcase
  end

  puts "Thank you for using the Ada Slack CLI!".blue
end

# Ruby uses __FILE__ to hold the current source file name
main if __FILE__ == $PROGRAM_NAME
