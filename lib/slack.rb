#!/usr/bin/env ruby
require_relative 'workspace'

OPTIONS = [
  ["1", "list users"],
  ["2", "list channels"],
  ["3", "quit"],
]

def main
  puts "Welcome to the Ada Slack CLI!"
  #workspace = Slack::Workspace.new

  choice = prompt_and_retrieve

  until OPTIONS.any? { |option| option.include? choice } do 
    puts "Invalid option, try again."
    choice = gets.strip.downcase
  end 

  case choice 
  when *OPTIONS[0]
    puts "chose option 1"
  when *OPTIONS[1]
    puts "chose option 2"
  when *OPTIONS[2]
    puts "chose option 3"
  end

  

  puts "Thank you for using the Ada Slack CLI"
end

def prompt_and_retrieve
  puts "MAIN MENU"
  OPTIONS.each do |option|
    puts option.join(" ")
  end
  print "What would you like to do? > "
  choice = gets.strip.downcase
  return choice
end

main if __FILE__ == $PROGRAM_NAME