#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'awesome_print'
require_relative 'workspace'

# TODO project
Dotenv.load




def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new


  



  puts "Thank you for using the Ada Slack CLI"
end

 main if __FILE__ == $PROGRAM_NAME