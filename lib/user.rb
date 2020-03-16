require 'httparty'
require 'table_print'

require_relative 'workspace.rb'
require_relative 'receiver.rb'


module SlackCLI
  class User < Receiver

    attr_reader :legal_name, :status_text, :status_emoji

    def initialize(legal_name:, status_text:, status_emoji:, id:, name:)
      super(id: id, name: name)
      
      @legal_name = legal_name
      @status_text = status_text 
      @status_emoji = status_emoji
    end 

    def summary
      tp self, "id", "name", "legal_name"
    end 

    def self.show_all
      clap_back = SlackCLI::User.get_url("https://slack.com/api/users.list") 
      users = []
      clap_back["members"].each do |spec|
        users << SlackCLI::User.new(
          legal_name: spec["real_name"],
          name: spec["name"],
          id: spec["id"],
          status_text: spec["profile"]["status_text"],
          status_emoji: spec["profile"]["status_emoji"]
        )
      end
      return users 
    end 
  end
end 