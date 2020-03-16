require_relative "workspace"

require "table_print"
require "dotenv"
require "httparty"

Dotenv.load

def main
  workspace = Workspace.new

  puts "\nWelcome to Nora's Slack API CLI. \nThis Slack workspace currently has #{workspace.users.length} users and #{workspace.channels.length} channels."
  action = menu_choice

  until action == "quit" || action == "6" || action == "exit" || action == "6) quit"
    case action
    when "list users", "users", "1", "1) list users"
      tp workspace.users, "name", "real_name", "slack_id"
      puts "\n"
    when "list channels", "channels", "2", "2) list channels"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
      puts "\n"
    when "select user", "user", "3", "3) select user"
      print "Please enter the user's name or ID: "
      user_input = gets.chomp
      puts workspace.select_user(user_input)
      puts "\n"
    when "select channel", "channel", "4", "4) select channel"
      print "Please enter the channel name or ID: "
      user_input = gets.chomp
      puts workspace.select_channel(user_input)
      puts "\n"
    when "details", "5", "5) details"
      if workspace.selected == nil
        puts "Oops! Please select a user or channel first."
        puts "\n"
      else
        workspace.show_details
        puts "\n"
      end
    else
      puts "Oops! I didn't understand you. Try again?"
      puts "\n"
    end

    action = menu_choice
  end

  puts "Thank you for using Nora's Slack CLI.\n"
end

def menu_choice
  print "Your options include: \n1) list users \n2) list channels \n3) select user \n4) select channel \n5) details \n6) quit \n\n"
  print "What would you like to do? "
  return gets.chomp.downcase
end

# The slack.rb file should not create, call, or use the User, Channel, or Recipient classes at all. The slack.rb file should mainly be interacting with the instance of Workspace created in the line workspace = Workspace.new. All User-related information that slack.rb receives should be returned from calling a method defined in the Workspace class.

main if __FILE__ == $PROGRAM_NAME
