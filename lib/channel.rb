require 'httparty'
require 'table_print'

require_relative 'workspace.rb'
require_relative 'receiver.rb'


module SlackCLI
  class Channel < Receiver 

    attr_reader :focus, :headcount

    def initialize(focus:, headcount:, id:, name:)
      @focus = focus
      @headcount = headcount
      super(id: id, name: name)
    end 

    def summary
      tp self, "id", "name", "focus", "headcount"
    end 

    def self.show_all 
      clap_back = SlackCLI::Channel.get_url("https://slack.com/api/conversations.list") 
      channels = []
      clap_back["channels"].each do |i|
        channels << SlackCLI::Channel.new(
          name: i["name"],
          id: i["id"],
          focus: i["topic"]["value"],
          headcount: i["num_members"] 
        )
      end
      return channels
    end
  end
end 