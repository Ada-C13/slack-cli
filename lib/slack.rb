#!/usr/bin/env ruby
require_relative 'workspace'
require 'table_print'
require 'colorize'
require 'terminal-table'

# Question: Is it a good practice to use WORKSPACE as a constant?
WORKSPACE = Slack::Workspace.new

OPTIONS = {
  "1" => ["list users", "list user"],
  "2" => ["list channels", "list channel"],
  "3" => ["select user"],
  "4" => ["select channel"],
  "5" => ["details", "detail", "show details"],
  "6" => ["send message", "send", "message"],
  "7" => ["change settings", "change setting", "setting"],
  "8" => ["check message history", "message history", "message list", "list message"],
  "9" => ["quit", "exit", "q", "bye"]
}


def display_options 
  puts "\nChoose one of the following options:"

  OPTIONS.each do |number, option|
    puts "  #{number}. #{option[0].blue}" 
  end 
end 


def get_option
  print "\n > "
  option = gets.chomp.downcase 
  option = validate_option(option) 
  puts "\n"

  return option
end 


def validate_option(option) 
  while !OPTIONS.keys.include?(option) && !OPTIONS.values.flatten.include?(option)
    puts "  #{"⚠️  You chose an invalid option!😅 Try again".light_black}."
    print " > "
    option = gets.chomp.downcase
  end 
  return option
end 


def get_user_name 
  puts "Select a user name, a real name, or a slack ID"
  print "> "
  name = gets.chomp
  name = validate_user_name(name) 

  return name
end 


def validate_user_name(name) 
  user = WORKSPACE.select_user(name) ##

  while user == nil
    puts "  #{"⚠️  No user found!😅 Try again".light_black}"
    print "> " 
    name = gets.chomp
    user = WORKSPACE.select_user(name) ##
  end 

  puts "  ✅ You've selected the username, #{user.name.bold} - #{user.slack_id}"
  return name
end 


def get_channel_name 
  puts "Select a channel name or a slack ID"
  print "> "
  name = gets.chomp
  channel = validate_channel_name(name) 

  puts "  ✅ You've selected the channel name, ##{channel.name.bold} - #{channel.slack_id}"

  return name
end 


def validate_channel_name(name)
  user = WORKSPACE.select_channel(name) ##

  while user == nil
    puts "No channel found!😅 Try again"
    print "> " 
    name = gets.chomp
    user = WORKSPACE.select_channel(name) ##
  end 

  return user
end 

def error_message 
  puts " #{"⚠️  No user or channel selected".light_black}"
  puts "    #{"After selecting one of them, try again!".light_black}"
end 


def display_details 
  details = WORKSPACE.show_details ##

  error_message if !details 

  details
end 


def get_recipient 
  WORKSPACE.selected.name if WORKSPACE.selected
end 


def get_message 
  recipient = "to #{get_recipient}"
  print "Enter your message #{recipient}"
  print " > "
  gets.chomp
end 


def validate_message(message)
  send_message = WORKSPACE.send_message(message)
  if !send_message
    error_message
  else 
    puts "  ✅ You've successfully sent a message to #{get_recipient}"
  end 
end 


def get_username 
  print "username > "
  gets.chomp
end 

def get_emoji 
  print "emoji > "
  gets.chomp
end 


def validate_setting(input, target)
  while input.empty?
    puts "  ⚠️  Invalid input. 😅 Try again"

    target == "username" ? input = get_username : input = get_emoji
  end
  return input
end 


def validate_history 
  message = WORKSPACE.message_history

  if !message 
    puts " #{"⚠️  No user or channel selected".light_black}"
    puts "    #{"After selecting a channel, try again!".light_black}"
    return false
  end 

  return message
end 


def display_history 
  message = validate_history

  if message 
    puts "Here is #{get_recipient}'s message history below:"
    rows = WORKSPACE.selected.message_history
    if rows.empty? 
      puts "  ☹️  Sorry! No message history found :("
    else 
      puts WORKSPACE.message_history
    end 
  end 
end 


def main
  puts "\nWelcome to the Ada Slack CLI!💬"
  workspace = Slack::Workspace.new

  puts "-------------------------"
  puts "##{workspace.users.length} users || ##{workspace.channels.length} channels" 
  puts "-------------------------"


  # TODO project

  display_options
  option = get_option

  continue = true 

  while continue 
    case option 
    when "1", *OPTIONS["1"] # list users
      WORKSPACE.list_users  
  
      display_options
      option = get_option

    when "2", *OPTIONS["2"]  # list channels 
      WORKSPACE.list_channels 
  
      display_options
      option = get_option

    when "3", *OPTIONS["3"]  # select user
      get_user_name

      display_options
      option = get_option

    when "4", *OPTIONS["4"] # select channel
      get_channel_name

      display_options
      option = get_option

    when "5", *OPTIONS["5"]  # detail
      display_details 
      
      display_options
      option = get_option
 
    when "6", *OPTIONS["6"] # send message
      message = get_message
      validate_message(message)

      display_options
      option = get_option

    when "7", *OPTIONS["7"] # change settings
      username = get_username 
      username = validate_setting(username, "username")

      emoji = get_emoji
      emoji = validate_setting(emoji, "emoji")

      WORKSPACE.change_setting(username, emoji)
      puts "  ✅ You've successfuly changed profile settings!"

      display_options
      option = get_option

    when "8", *OPTIONS["8"] # check message history
      display_history

      display_options
      option = get_option

    when "9", *OPTIONS["9"] # quit
      puts "Bye 👋👋🏻👋🏼👋🏽👋🏾👋🏿"
      continue = false
    end 
  end 


  puts "\nThank you for using the Ada Slack CLI 😊"
end

main if __FILE__ == $PROGRAM_NAME



# =============================================
# output 
# =============================================

# Welcome to the Ada Slack CLI!💬
# -------------------------
# #12 users || #6 channels
# -------------------------

# Choose one of the following options:
#   1. list users
#   2. list channels
#   3. select user
#   4. select channel
#   5. details
#   6. send message
#   7. change settings
#   8. check message history
#   9. quit

#  > 1

# NAME                  | REAL_NAME             | SLACK_ID   
# ----------------------|-----------------------|------------
# sea otter             | Slackbot              | USLACKBOT  
# space_lee_api_project | space_lee_api_project | UUTG4NT6W  
# faezeh.ashtiani       | Faezeh Ashtiani       | UUV26URFC  
# hannahjoo24           | Hannah J              | UUVTM0ZJM  
# time_hannah_j_api_pro | time_hannah_j_api_pro | UV6BLS99N  
# acirizarry            | Antonia               | UV6BN9RTP  
# space_faezeh_slackcli |                       | UV7EPA5EG  
# sara.lee.higgins      | Lee Higgins           | UV7S06J4X  
# hannahtekie           | Hannah Tekie          | UV8PPJX37  
# time_hannaht_api_proj | time_hannaht_api_proj | UV8Q8T6S1  
# space_antonia_slack_a | space_antonia_slack_a | UVDHLDG0N  
# space_faezeh_slack_ap | space_faezeh_slack_ap | U0102NT1RE3

# Choose one of the following options:
#   1. list users
#   2. list channels
#   3. select user
#   4. select channel
#   5. details
#   6. send message
#   7. change settings
#   8. check message history
#   9. quit

#  > 2

# NAME              | TOPIC                          | MEMBER_COUNT | SLACK_ID 
# ------------------|--------------------------------|--------------|----------
# lees-test-channel | For having fun with the Sla... | 2            | CUT6YR3LJ
# general           | Company-wide announcements ... | 5            | CV60LA20G
# random            | Non-work banter and water c... | 5            | CV86T0TPY
# hannah-j-test     |                                | 2            | CV8HLGW9L
# hannahmary        |                                | 5            | CV8PR7M4M
# fun               |                                | 5            | CVB8WV8BS

# Choose one of the following options:
#   1. list users
#   2. list channels
#   3. select user
#   4. select channel
#   5. details
#   6. send message
#   7. change settings
#   8. check message history
#   9. quit

#  > 3

# Select a user name, a real name, or a slack id
# > sea otter
#   ✅ You've selected the user name, sea otter - USLACKBOT

# Choose one of the following options:
#   1. list users
#   2. list channels
#   3. select user
#   4. select channel
#   5. details
#   6. send message
#   7. change settings
#   8. check message history
#   9. quit

#  > 5

# SLACK_ID  | NAME      | REAL_NAME | STATUS_TEXT | STATUS_EMOJI
# ----------|-----------|-----------|-------------|-------------
# USLACKBOT | sea otter | Slackbot  |             | 🦦           

# Choose one of the following options:
#   1. list users
#   2. list channels
#   3. select user
#   4. select channel
#   5. details
#   6. send message
#   7. change settings
#   8. check message history
#   9. quit

#  > 6

# Enter your message to sea otter > I love flower!
#   ✅ You've successfully sent a message to sea otter

# Choose one of the following options:
#   1. list users
#   2. list channels
#   3. select user
#   4. select channel
#   5. details
#   6. send message
#   7. change settings
#   8. check message history
#   9. quit

#  > 8

# Here is sea otter's message history below:
# +-------------+----------------------------+---------------------------+
# | username    | text                       | timestamp                 |
# +-------------+----------------------------+---------------------------+
# | hannahjoo24 | I love flower!             | 2020-03-16 01:44:17 -0700 |
# | hannahjoo24 | Winter is coming           | 2020-03-16 01:39:44 -0700 |
# | My Bot      | any body alive down there? | 2020-03-16 01:00:48 -0700 |
# | hannahjoo24 | im still awake!            | 2020-03-16 00:56:40 -0700 |
# | hannahjoo24 | howdy!                     | 2020-03-15 10:39:14 -0700 |
# | My Bot      | sea otter is cute          | 2020-03-14 23:58:49 -0700 |
# | My Bot      | yum yum                    | 2020-03-14 23:48:39 -0700 |
# | hannahjoo24 | Hey                        | 2020-03-14 23:38:32 -0700 |
# | My Bot      | ^-^                        | 2020-03-14 23:16:16 -0700 |
# | My Bot      | hell yeah                  | 2020-03-14 21:44:01 -0700 |
# +-------------+----------------------------+---------------------------+

# Choose one of the following options:
#   1. list users
#   2. list channels
#   3. select user
#   4. select channel
#   5. details
#   6. send message
#   7. change settings
#   8. check message history
#   9. quit

#  > 4

# Select a channel name or a slack id
# > hannah-j-test
#   ✅ You've selected the channel name, #hannah-j-test - CV8HLGW9L

# Choose one of the following options:
#   1. list users
#   2. list channels
#   3. select user
#   4. select channel
#   5. details
#   6. send message
#   7. change settings
#   8. check message history
#   9. quit

#  > 5

# SLACK_ID  | NAME          | TOPIC | MEMBER_COUNT
# ----------|---------------|-------|-------------
# CV8HLGW9L | hannah-j-test |       | 2           

# Choose one of the following options:
#   1. list users
#   2. list channels
#   3. select user
#   4. select channel
#   5. details
#   6. send message
#   7. change settings
#   8. check message history
#   9. quit

#  > 6

# Enter your message to hannah-j-test > im hungryyyy!
#   ✅ You've successfully sent a message to hannah-j-test

# Choose one of the following options:
#   1. list users
#   2. list channels
#   3. select user
#   4. select channel
#   5. details
#   6. send message
#   7. change settings
#   8. check message history
#   9. quit

#  > 8

# Here is hannah-j-test's message history below:
# +-------------+--------------------------------------+---------------------------+
# | username    | text                                 | timestamp                 |
# +-------------+--------------------------------------+---------------------------+
# | hannahjoo24 | im hungryyyy!                        | 2020-03-16 01:45:20 -0700 |
# | hannahjoo24 | hihi                                 | 2020-03-16 01:13:31 -0700 |
# | My Bot      | nooooooice!                          | 2020-03-16 01:01:35 -0700 |
# | hannahjoo24 | gooooood morning!                    | 2020-03-15 10:50:51 -0700 |
# | My Bot      | 0                                    | 2020-03-14 23:50:20 -0700 |
# | My Bot      | Is there anybody alive down there??! | 2020-03-14 23:40:20 -0700 |
# | hannahjoo24 | What up?                             | 2020-03-14 23:16:48 -0700 |
# | My Bot      | ^-^                                  | 2020-03-14 23:16:31 -0700 |
# | hannahjoo24 | Coding is awesome                    | 2020-03-14 23:15:23 -0700 |
# | My Bot      | HELLO SEATTLE!!                      | 2020-03-14 22:57:09 -0700 |
# +-------------+--------------------------------------+---------------------------+

# Choose one of the following options:
#   1. list users
#   2. list channels
#   3. select user
#   4. select channel
#   5. details
#   6. send message
#   7. change settings
#   8. check message history
#   9. quit

#  > 7

# username > sea otter
# emoji > 🦦
#   ✅ You've successfuly changed profile settings!

# Choose one of the following options:
#   1. list users
#   2. list channels
#   3. select user
#   4. select channel
#   5. details
#   6. send message
#   7. change settings
#   8. check message history
#   9. quit

#  > 9

# Bye 👋👋🏻👋🏼👋🏽👋🏾👋🏿

# Thank you for using the Ada Slack CLI 😊