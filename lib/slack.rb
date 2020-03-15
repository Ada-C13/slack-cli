# #!/usr/bin/env ruby
require "httparty"
require "table_print"
require_relative "workspace"

Dotenv.load 

 def main
  workspace = SlackApp::Workspace.new
  puts "Welcome to the Ada Slack CLI! We have #{workspace.users.size} and #{workspace.channels.size}"

  puts "Please choose an option: list users, list channels, select user, select channel, details, send message, or quit:"
  user_input = gets.chomp.downcase 

  until user_input == "quit"

  case user_input
  when "list users"
    tp workspace.users, "slack_id", "name", "real_name" 
    puts ""

  when "list channels"
    tp workspace.channels, "name", "topic", "member_count", "slack_id"
    puts ""

  when "select user"
    print "Please enter the user name or ID: "
    puts workspace.select_user(gets.chomp)
    puts ""

  when "select channel"
    print "Please enter the channel name or ID: "
    puts workspace.select_channel(gets.chomp)
    puts ""

  when "details"
    if workspace.selected == nil
      puts "Please select a user or channel."
    else
      workspace.show_details
    end 
  when "send message"
    if workspace.selected == nil
      puts "Please select a user or channel."
    else
      print "Please enter your message: "
      workspace.send_message
    end
  else
    puts "Sorry, I didn't understand your request. Please try again."
    puts ""
  end
  puts "Please choose an option: list users, list channels, select user, select channel, details, send message, or quit:"
  user_input = gets.chomp.downcase 
  puts "Thank you for using the Ada Slack CLI"
  puts ""
  end 
end
main if __FILE__ == $PROGRAM_NAME