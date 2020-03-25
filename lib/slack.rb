#!/usr/bin/env ruby
require_relative 'workspace'
require "table_print"

OPTIONS = [
  ["1", "list users"],
  ["2", "list channels"],
  ["3", "select user"],
  ["4", "select a channel"],
  ["5", "quit"],
]

def main
  puts "Welcome to the Ada Slack CLI!"
  @workspace = Slack::Workspace.new

  #MAIN LOOP 
  choice = get_user_input
  until (OPTIONS[-1].include? choice)
    perform_action(choice)
    choice = get_user_input
  end
  puts "\n>>>>>> Thank you for using the Slack CLI! Goodbye."
end

def perform_action(choice)

  until OPTIONS.any? { |option| option.include? choice } 
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
      make_selection("user", @workspace.users )
      
    when *OPTIONS[3]
     make_selection("channel", @workspace.channels )
      
      
  end

end

def get_user_input
  puts "\n\nMAIN MENU - please select from the following"

  OPTIONS.each do |option|
    puts option.join(" ")
  end
  
  print "\nWhat would you like to do? > "
  choice = gets.strip.downcase
  return choice
end

def make_selection(type, list)
  puts "\n\n>>>>>>> SELECTING A #{type.upcase}"
  print "Please enter the #{type} number or the ID as listed > "
  input = gets.strip

  if input != 0 && input.to_i == 0 #gave us an ID
    @workspace.select_by_id(type, input)
  else #gave us an int 
    while input == 0 || input.to_i > list.length
      validate_selection(input)
    end
    @workspace.select_by_index(type, input.to_i-1)
  end

  puts "Selected #{type}: #{@workspace.selected.name}"
  
end

def validate_selection(input)
  print "#{input} is not a valid choice, re-enter the number > "
  return gets.strip
end


main if __FILE__ == $PROGRAM_NAME



