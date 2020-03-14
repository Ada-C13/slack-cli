#!/usr/bin/env ruby

require "table_print"
require "dotenv"
require "httparty"

# Dotenv.load --why is this necessary/how is it working? 

require_relative 'workspace.rb'

def main
  puts "Welcome to the Ada Slack CLI!\n\n"
  workspace = Workspace.new

  puts "The Ada Slack CLI can do several things:\n
  -list users\n
  -list channels\n
  -choose user\n
  -choose channel\n
  -summary\n
  -send message\n"





  puts "The users of this program are: #{@users}\n\n" 
  
  puts "The channels of this program are: #{@channels}\n\n"

  puts "Thank you for using the Ada Slack CLI\n\n"

  # make method to prompt for input 

end

main if __FILE__ == $PROGRAM_NAME