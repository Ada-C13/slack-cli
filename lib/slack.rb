#!/usr/bin/env ruby
require 'dotenv'
require "table_print"

require_relative "workspace"

Dotenv.load 

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new


  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME