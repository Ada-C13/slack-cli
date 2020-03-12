#!/user/bin/env ruby
require "httparty"
require "awesome_print"
require "dotenv"
require_relative 'workspace'
require_relative 'recipient'
require_relative 'user'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new
  ap workspace.users

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
