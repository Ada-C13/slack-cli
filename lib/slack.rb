require "dotenv"
require "table_print"

require_relative "recipient"
require_relative "user"
require_relative "channel"
require_relative "workspace"

Dotenv.load

VALID_COMMANDS = ['list users', 'list channels', 'select user', 'select channel',
  'details', 'send message', 'quit']

VALID_SEARCH = ['name', 'id']

def user_prompt
  puts "\nSelect from the following options: \n* List Users \n* List Channels \n* Select User \
  \n* Select Channel \n* Details \n* Send Message  \n* Quit"
  return gets.chomp.downcase
end

def input_validation
  input = gets.chomp.downcase 
  until VALID_COMMANDS.include? input
    puts "I didn't understand your gibberish."
    puts "Please enter a valid command"
    user_prompt
    input = gets.chomp.downcase
  end 
  return input # implied?
end

def search_selected
  puts "Do you want to search by name or id?"
  key = gets.chomp.downcase 

  until VALID_SEARCH.include? key
    puts "Invalid command - Do you want to search for name or id"
    key = gets.chomp.downcase 
  end 
  
  puts "Please enter #{key}:"
  input = gets.chomp
  key == 'name' ? {name: input} : {slack_id: input}
end

def main
  workspace = Workspace.new
  puts "\nWelcome to Ada's Slack CLI"
  # Display how many users and channels are available
  puts "Slack Workspace currently has: \n#{workspace.users.count} Users \n#{workspace.channels.count} Channels" 

  # Get user input from available options
  loop do
    user_input = user_prompt
    case user_input
      when "list users"
        puts tp workspace.users, "slack_id", "name", "real_name"
      when "list channels"
        puts tp workspace.channels, "name", "topic", "num_members", "slack_id"
      when "select channel"
        channel_selected = search_selected
        workspace.select_channel(channel_data)
        workspace.selected ? workspace.show_selected : puts("Channel not found")
      when "quit"
        puts "Okay you want to quit. Goodbye"
        break
      else  
        user_prompt
      end
    end
  puts "Thank you for using Ada's Slack CLI"
  end

main if __FILE__ == $PROGRAM_NAME