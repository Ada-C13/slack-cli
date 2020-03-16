require 'httparty'
require 'dotenv'
require 'table_print'


require_relative 'workspace'

Dotenv.load

def main
  puts "~Welcome to the Ada Slack CLI!~"
  workspace = Workspace.new
  puts "\n\n*******************************"
  #info about channels and users

  puts "\n\nHere's the info about this workspace: "
  puts "\n"
  tp workspace.channels, "name", "topic", "member_count", "slack_id"
  puts "\n"
  tp workspace.users, "slack_id", "username", "real_name"

  choice = ""

  until choice == "quit"
    puts "\n\nWhat would you like to do?:"
    puts "\nOptions:\n- List Users\n- List Channels\n- Select User\n- Select Channel\n- Details\n- Send Message\n- Quit (type 'quit')"

    choice = gets.chomp

    case choice.downcase
      when "list users"
        tp workspace.users, "slack_id", "username", "real_name"
      when "list channels"
        tp workspace.channels, "name", "topic", "member_count", "slack_id"
      when "select user"
        puts "\nPlease enter the username or Slack ID of the user you'd like to select:"
        puts workspace.select_user
      when "select channel"
        puts "\nPlease enter the name or Slack ID of the channel you'd like to select:"
        puts workspace.select_channel
      when "details"
        workspace.selected ? workspace.selected.details : (puts "\nPlease select a recipient first.")
      when "send message"
        if !workspace.selected
          puts "Please select a recipient before sending a message."
        else
          puts "Please enter your message:"
          workspace.send_message
        end
      when "quit"
        puts "\nThank you for using the Ada Slack CLI!"
      else
        puts "\n\nI'm sorry, #{choice} is not a recognized option."
    end
  end
end

main if __FILE__ == $PROGRAM_NAME