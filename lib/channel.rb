require_relative 'recipient'
Dotenv.load 


TOKEN = ENV["SLACK_API_TOKEN"]
BASE_URL = "https://slack.com/api/"


module SlackCli
  class Channel < Recipient
    attr_reader :member_count, :topic

    def initialize(slack_id:,name:,member_count:,topic:)
      super(slack_id,name)
      @member_count = member_count
      @topic = topic 
    end

    def self.get_all
      data = HTTParty.get("#{BASE_URL}conversations.list",query: {token:TOKEN})["channels"]
      empty_array = []
      data.each do |channel|
        empty_array << new(slack_id: channel["id"], name: channel["name"], member_count:channel["num_members"], topic:channel["topic"]["value"])
      end 
      return empty_array 
    end 
  
  end
end