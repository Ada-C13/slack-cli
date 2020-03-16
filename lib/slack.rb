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
    puts "\nWhat would you like to do?"
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
      puts "enter username or slack ID of a user"
      select_user = gets.chomp.downcase
      workspace.select_user(select_user)
      if workspace.selected.nil?
        puts "no such user exists 😢"
      elsif workspace.selected != nil 
        puts "you've selected a user yay! 🤗"
      end
    when "select channel"
      puts "enter username or slack ID of a channel"
      select_channel = gets.chomp.downcase
      workspace.select_channel(select_channel)
      if workspace.selected.nil?
        puts "no such channel exists 🤔"
      elsif workspace.selected != nil 
        puts "you've selected a channel yay! 🥳"
      end

      
    when "details"
      if workspace.selected.nil?
        puts "please select a user or channel to get details on"
      else
        puts workspace.details_of
      end
    when "send message"
      puts "what is your message?"
      message = gets.chomp
      until message != nil && message != ""
        puts "enter your message"
        message = gets.chomp
      end

      if workspace.selected.nil?
        puts "you must choose a channel or a user before you send a message"
      elsif workspace.text_me(message) == false
        puts "unable to send your message 🥺"
      else
        puts "your message has been succefully sent 📨"
      end
    when "quit"
      break
    end
  end

  puts "Thank you for using the Mair Bear's Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
