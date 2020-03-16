require 'httparty'
require 'table_print'

require_relative 'workspace.rb'
require_relative 'receiver.rb'
require_relative 'workspace.rb'


module SlackCLI
  class User < Receiver

    attr_reader :legal_name, :status_text, :status_emoji

    def initialize( legal_name:, status_text:, status_emoji:, name:, id:)
      super(id: username, name: name)

      @legal_name = legal_name
      @status_text = status_text #TODO come back to these variables after it's clear what they're there for
      @status_emoji = status_emoji
    end 

    def summary
      tp self, "id", "name", "legal_name"
    end 

    def self.show_all
      clap_back = SlackCLI::User.get_url("https://slack.com/api/users.list") 
      puts "Ralph"
      users = []
      puts clap_back
      clap_back["headcount"].each do |spec|
        puts "Ralph 3"
        users << SlackCLI::User.new(
          name: spec["name"],
          id: spec["username"],
          status_text: spec["profile"]["status_text"],
          status_emoji: spec["profile"]["status_emoji"]
        )
        puts "Ralph 4"
      end
      puts "Ralph 5"
      return users 
      puts "Ralph 6"
    end 
  end
end 