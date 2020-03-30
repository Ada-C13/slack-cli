#!/usr/bin/env ruby
require_relative 'workspace'
require "table_print"

OPTIONS = [
  ["1", "list users"],
  ["2", "list channels"],
  ["3", "select user"],
  ["4", "select a channel"],
  ["5", "show details"],
  ["6", "post a message"],
  ["7", "quit"],
]

# main loop of the CLI program
def main
  puts "Welcome to the Ada Slack CLI!"
  @workspace = Slack::Workspace.new

  choice = get_user_input
  until (OPTIONS[-1].include? choice) #checks for quit command from user
    perform_action(choice)
    choice = get_user_input
  end
  puts "\n>>>>>> Thank you for using the Slack CLI! Goodbye."
end

# prompts for valid commands from user, then executes the command
def perform_action(choice)

  until OPTIONS.any? { |option| option.include? choice } #validates user input
    print "'#{choice}' is an invalid option, try again. > "
    choice = gets.strip.downcase
  end 
  
  case choice 
    when *OPTIONS[0]
      puts "\n\n>>>>>>> LIST OF USERS"
      count = 0
      my_proc = Proc.new{count = count + 1}
      tp @workspace.users, {user: lambda{ |u| my_proc.call }}, :id, :user_name, :real_name => {:display_method => :name}

    when *OPTIONS[1]
      puts "\n\n>>>>>>> LIST OF CHANNELS"
      # tp @workspace.channels, :include => :id
      count = 0
      my_proc = Proc.new{count = count + 1}
      tp @workspace.channels, {channel: lambda{ |u| my_proc.call }}, :id, :name, :topic, :member_count

    when *OPTIONS[2]
      make_selection("user", @workspace.users)
      
    when *OPTIONS[3]
     make_selection("channel", @workspace.channels)

    when *OPTIONS[4] #details
      if @workspace.selected.nil?
        puts "ERROR: Oops, you haven't made a selection yet. Make a selection first."
      else
        puts @workspace.selected.details
      end

    when *OPTIONS[5] #post message
      if @workspace.selected.nil?
        puts "ERROR: Who ya trying to send a message to? Pick someone first, silly."
      else
        print "Enter the message that you want to send to #{@workspace.selected.name} > "
        message = gets
        @workspace.selected.post_message(message)
      end
  end

end

# presents the main menu and grabs user input
def get_user_input
  puts "\n\nMAIN MENU - please select from the following"

  OPTIONS.each do |option|
    puts option.join(" ")
  end
  
  print "\nWhat would you like to do? > "
  choice = gets.strip.downcase
  return choice
end

# gets user input when they're selecting a user or channel
def make_selection(type, list)
  puts "\n\n>>>>>>> SELECTING A #{type.upcase}"
  print "Please enter the #{type} number or the ID as listed > "
  input = gets.strip

  if input != 0 && input.to_i == 0 #gave us an ID
    puts "checking id #{input}..."
    begin
    @workspace.select_by_id(type, input)
    rescue ArgumentError
      puts "No #{type} with that ID exists."
    else
      puts "Selected #{type}: #{@workspace.selected.name}"
    end
  else #gave us an integer
    puts "checking for user ##{input}..."
    while input == 0 || input.to_i > list.length
      input = validate_selection(input)
    end
    @workspace.select_by_index(type, input.to_i-1)
    puts "Selected #{type}: #{@workspace.selected.name}"
  end
end

# helper method to validate 
def validate_selection(input)
  print "#{input} is not a valid choice, re-enter the number or ID > "
  return gets.strip
end


main if __FILE__ == $PROGRAM_NAME



