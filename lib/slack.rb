#!/usr/bin/env ruby
require_relative 'workspace'
require "table_print"

OPTIONS = [
  ["1", "list users"],
  ["2", "list channels"],
  ["3", "quit"],
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
      tp @workspace.users
    when *OPTIONS[1]
      puts "\n\n>>>>>>> LIST OF CHANNELS"
      tp @workspace.channels
      # TO-DO tp @workspace.channels.exclude direct messages
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


main if __FILE__ == $PROGRAM_NAME



