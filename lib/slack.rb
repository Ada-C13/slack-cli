require "httparty"
require "dotenv"
require "awesome_print"
require_relative "workspace"

def main
  puts "Welcome to the Mair Bear's Slack CLI!"
  workspace = Workspace.new
  puts "There are #{workspace.channels.length} channels and #{workspace.users.length} users in this Slack."

  def pretty_user_list(workspace)
    workspace.users.each do |user|
      puts "🔸#{user.details}"
      puts ""
    end
  end

  def pretty_channel_list(workspace)
    workspace.channels.each do |channel|
      puts "🔸#{channel.details}"
      puts ""
    end
  end

  while true
    puts "What would you like to do?"
    puts "\n🔵 list users\n🔵 list channels\n🔵 select user\n🔵 select channel\n🔵 details\n🔵 send message\n🔵 quit"
    options = ["list users", "list channels", "select user", "select channel", "details", "quit", "send message"]
    users_option = gets.chomp.downcase
    until options.include? users_option
      puts "Please input a valid command."
      users_option = gets.chomp.downcase
    end

    case users_option
    when "list users"
      pretty_user_list(workspace)
    when "list channels"
      pretty_channel_list(workspace)
    when "select user"
      puts "enter name of a user"
      select_user = gets.chomp.downcase
      puts workspace.select_user(select_user)
    when "select channel"
      puts "enter name of a channel"
      select_channel = gets.chomp.downcase
      puts workspace.select_channel(select_channel)
    when "details"
      puts workspace.details_of #colorize?
    when "send message"
      puts "what is your message?"
      message = gets.chomp.downcase
      workspace.text_me(message)
    when "quit"
      break
    end
  end

  puts "Thank you for using the Mair Bear's Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

#do something that tells the user their message has been sent
#return "Your message has been sent 📨" if response["okay"] == true
