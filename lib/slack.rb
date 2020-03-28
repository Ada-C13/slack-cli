require "dotenv"
require "httparty"
require "table_print"
require "awesome_print"

require_relative "workspace"

Dotenv.load

SLACK_TOKEN = ENV["SLACK_TOKEN"]

def allowed_input
  puts "Your options are: list users, list channel, select user, 
  select channel, details, and send message or quit: what would you like to see?"
  return gets.chomp()
end

def main
  workspace = SlackCLI::Workspace.new
  puts "Welcome to the Ada Slack CLI!
  at this time, our workspace has #{workspace.users.count} users
  and #{workspace.channels.count} channels."

  user_input = allowed_input

  until user_input == "quit" || user_input == "exit"
    case user_input

    when "list users"
      tp workspace.users, "slack_id", "name"
      puts "\n"
    when "list channel"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
      puts "\n"
    when "select user"
      puts "please enter a user name or slack_id"
      user_input = gets.chomp()
      if workspace.select_user(user_input) == nil
        puts "no user with that user name exist"
      else
        puts "selected user with id #{workspace.selected.slack_id}"
      end
    when "select channel"
      puts "please enter a channel name or slack_id"
      user_input = gets.chomp()
      if workspace.select_channel(user_input) == nil
        puts "no channel with that channel name exist"
      else
        puts "selected channel with id #{workspace.selected.slack_id}"
      end
    when "detail", "details"
      if workspace.selected == nil
        puts "no user selected"
      else
        ap workspace.selected.print_details
      end
      if workspace.selected == nil
        puts "no channel selected"
      else
        ap workspace.selected.print_details
      end
    when "send message"
      if workspace.selected == nil
        puts "you need to selec a user or a channel."
        puts "\n"
      else
        puts "enter your message: "
        user_input = gets.chomp()
        success = workspace.send_message(user_input)
        puts "\n"
        puts "sent message" if success
      end
    end

    user_input = allowed_input
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
