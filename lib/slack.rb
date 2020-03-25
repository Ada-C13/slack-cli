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
      tp workspace.channels, "name", "topic", "members", "id"
      puts "\n"
    end
    puts "what would you like to see?"
    user_input = gets.chomp()
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
