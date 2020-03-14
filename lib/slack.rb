# # #!/usr/bin/env ruby
# require "dotenv"
# require "httparty"
# require "table_print"
# require_relative "workspace"

# Dotenv.load 

#  def main
#   workspace = SlackApp::Workspace.new
#   puts "Welcome to the Ada Slack CLI! We have #{workspace.users.size} and #{workspace.channels.size}"

#   puts "Please choose an option: list users, list channels, select user, select channel, details, send message, or quit:"
#   user_input = gets.chomp.downcase 

#   until user_input == "quit"

#   case user_input
#   when "list users"
#     workspace.users 

#   when "list channels"
#     workspace.channels

#   when "select user"
#     print "Please enter the user name or ID: "
#     puts workspace.select_user(gets.chomp)

#   when "select channel"
#     print "Please enter the channel name or ID: "
#     puts workspace.select_channel(gets.chomp)

#   when "details"
#     if workspace.selected == nil
#       puts "Please select a user or channel."
#     else
#       workspace.show_details
#       #user_input = nil
#     end 
#   end 
#     user_input = gets.chomp.downcase 
  

#   puts "Thank you for using the Ada Slack CLI"
# end

# main if __FILE__ == $PROGRAM_NAME