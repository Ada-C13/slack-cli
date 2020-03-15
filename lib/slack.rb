require "dotenv"
require "httparty"
require "table_print"

require_relative "workspace"

Dotenv.load

def main
  workspace = Workspace.new 
  puts "\n"
  puts "Welcome to the Ada Slack CLI! This Slack workspace currently has #{workspace.users.count} users and #{workspace.channels.count} channels."

  user_input = prompt_for_input

  until user_input == "quit" || user_input == "exit"
    
    case user_input
    when "list users"
      tp workspace.users, "id", "name", "real_name" 
      puts "\n"
      
    when "list channels"
      tp workspace.channels, "name", "topic", "members", "id"
      puts "\n"
      
    when "select user"
      print "Please enter the user name or ID: "
      tp workspace.select_user(gets.chomp), "id", "name", "real_name"
      puts "\n"
      
    when "select channel"
      print "Please enter the channel name or ID: "
      tp workspace.select_channel(gets.chomp), "name", "topic", "members", "id"
      puts "\n"
      
    when "details"
      if workspace.selected == nil
        puts "Please select a user or channel."
        puts "\n"
      elsif workspace.selected.is_a?(User)
        tp workspace.show_details, "id", "name", "real_name"
        user_input = nil
        puts "\n"
      else
        tp workspace.show_details, "name", "topic", "members", "id"
        user_input = nil
        puts "\n"
      end 
    when "send message"
      if workspace.selected == nil
        puts "Please select a user or channel."
        puts "\n"
      else
        print "Please enter your message: "
        workspace.send_message
        puts "\n"
      end
    else
      puts "Sorry, I didn't understand your request. Please try again."
      puts "\n"
    end

    user_input = prompt_for_input
  end 
  puts "Thank you for using the ADA Slack CLI!"
  puts "\n"
end

def prompt_for_input
  print "Please choose from the options: list users, list channels, select user, select channel, details, send message, or quit: \n"
  return gets.chomp.downcase
end

main if __FILE__ == $PROGRAM_NAME