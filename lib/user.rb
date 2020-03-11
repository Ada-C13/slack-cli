require_relative 'recipient'
Dotenv.load 
TOKEN = ENV["SLACK_API_TOKEN"]
BASE_URL = "https://slack.com/api/"

module SlackCli
  class User < Recipient

    attr_reader :real_name
    def initialize(slack_id:,name:,real_name:)
      super(slack_id,name)
      @real_name = real_name
    end

    def self.get_all
      data = HTTParty.get("#{BASE_URL}users.list",query: {token:TOKEN})["members"]
      empty_array = []
      data.each do |member|
        empty_array << new(slack_id: member["id"], name: member["name"], real_name:member["real_name"])
      end 
      return empty_array 
    end 

  
  end
end