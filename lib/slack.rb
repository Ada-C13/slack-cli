#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'

require_relative 'workspace.rb'

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

