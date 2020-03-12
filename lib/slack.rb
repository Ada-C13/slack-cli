#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'table_print'
require_relative 'workspace'


def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCli::Workspace.new

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME