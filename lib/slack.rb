#!/usr/bin/env ruby

require 'dotenv'
require 'httparty'
require_relative 'workspace'

module SlackCLI
  def main
    puts "Welcome to the Ada Slack CLI!"
    workspace = Workspace.new
    workspace.load_users

    puts "#{ workspace.channels.length } channels loaded.."
    puts "#{ workspace.users.length } users loaded.."
    puts "What would you like to do ?\n1. List users\n2. List channels\n3. Quit"

    # TODO project

    puts "Thank you for using the Ada Slack CLI"
  end
end

main if __FILE__ == $PROGRAM_NAME