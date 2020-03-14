require "dotenv"
require "httparty"
require "table_print"

require_relative "recipient"
require_relative "user"
require_relative "channel"
require_relative "workspace"

Dotenv.load

def user_prompt
  puts "\nSelect from the following options: \n*List Users \n*List Channels \n*Quit"
  return gets.chomp.downcase
end

def main
  workspace = Workspace.new
  # wave 1 Display how many users and channels are available
  puts "Welcome to the Ada Slack CLI!"
  puts "The Slack workspace currently has #{workspace.users.count} users and #{workspace.channels.count} channels." 
  user_input = user_prompt
  
  # Get user input from available options
  while user_input != "quit"
    if user_input == "list users"
      tp workspace.users, "slack_id", "name", "real_name"
    elsif user_input == "list channels"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
    elsif user_input == "quit"
      puts "Okay you want to quit. Goodbye"
    else
      puts "I didn't understand your selection"  
    end
    user_input = user_prompt
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME