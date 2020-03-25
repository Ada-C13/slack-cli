require "dotenv"
require "httparty"
require "table_print"

require_relative "workspace"

Dotenv.load

SLACK_TOKEN = ENV["SLACK_TOKEN"]

def main
  workspace = Workspace.new
  puts "Welcome to the Ada Slack CLI!
  at this time, our workspace has #{workspace.users.count} users
  and #{workspace.channels.count} channels."

  # TODO project

  puts "what would you like to see?"
  user_input = gets.chomp()
  until user_input == "quit" || user_input == "exit"
    case user_input

    when "list users"
      tp workspace.users, "id", "name"
      puts "\n"
    when "list channel"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
      puts "\n"

    when "select user"
      puts "please enter a user name or id"
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
    end

    puts "what would you like to see?"
    user_input = gets.chomp()
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
