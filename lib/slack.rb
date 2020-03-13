#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'awesome_print'
require_relative 'workspace'
require_relative 'channel'

# TODO project
Dotenv.load


def main
  puts "Welcome to the Ada Slack CLI!"
  puts "Please choose from the following options:"
  #workspace = Workspace.new
  print_channels



  puts "Thank you for using the Ada Slack CLI"
end
  

def print_channels
  channels_list = Channel.list_all
  channels_list.each do |channel|
   puts channel.name + (', ') + channel.topic  + (', ') + channel.members.to_s  + (', ') + channel.id

  end

end

 

 main if __FILE__ == $PROGRAM_NAME