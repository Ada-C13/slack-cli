require 'httparty'
require 'dotenv'
require 'table_print'


require_relative 'workspace'

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  #info about channels and users

  puts "\nHere's the info about this workspace: "

  puts "\nChannels: #{workspace.channels}"
  puts "\nUsers: #{workspace.users}"

  choice = ""

  until choice == "quit"
    puts "\n\nWhat would you like to do?:"
    puts "\nOptions:\n- List User (type 'users')\n- List Channels (type 'channels')\n- Quit (type 'quit')"

    choice = gets.chomp

    if choice == "users"
      tp workspace.users, "slack_id", "username", "real_name"
    elsif choice == "channels"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
    else
      puts "\n\nI'm sorry, #{choice} is not a recognized option."
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME