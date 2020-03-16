#coded along with Devin for Wave 1
#!/usr/bin/env ruby

require 'httparty'
require 'dotenv'
Dotenv.load
require 'table_print'
require_relative 'workspace'


def main
  workspace = Workspace.new 

  puts "\n"
  puts "Welcome to the Ada Slack CLI! This Slack workspace currently has #{workspace.users.length} users and #{workspace.channels.length} channels."

  user_input = input_prompt

  #really liked this way of formatting after seeing it on the Wave 1 Live Code vs using if-elsif statements
  ##changed my formatting to match. 
  until user_input == "Quit"
    
    case user_input
    when "List users"
      tp workspace.users, "slack_id", "name", "real_name", "status_emoji", "status_text"
      puts "\n"
      
    when "List channels"
      tp workspace.channels, "name", "slack_id", "topic", "member_count"
      puts "\n"
      
    when "Select user"
      print "Please enter user name or ID: "
      puts workspace.select_user
      puts "\n"
      
    when "Select channel"
      print "Please enter channel name or ID: "
      puts workspace.select_channel
      puts "\n"
      
    when "Details"
      workspace.show_details

    when "Send message"
      workspace.send_message
      
    else
      puts "Sorry, I didn't understand your request. Please try again."
    end

    user_input = input_prompt
  end 

  puts "Thank you for using the ADA Slack CLI!"
  puts "\n"

end

def input_prompt
  puts "What would you like to do? Your options are:" 
  puts "List users \nList channels \nSelect user \nSelect channel \nDetails \nSend message \nQuit"
  puts "\n"

  return gets.chomp.capitalize
end

main if __FILE__ == $PROGRAM_NAME