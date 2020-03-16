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
      response = SlackCLI::Channel.get("https://slack.com/api/conversations.list") 

      channels = []

      clap_back["channels"].each do |i|
        channels << SlackCLI::Channel.new(
          name: i["name"],
          id: i["id"],
          focus: i["focus"],
          headcount: i[""] #revisit this and fill out later 
        )
      end
      return channels
    end
  end
end 