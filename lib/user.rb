require_relative 'recipient'

module SlackCli
  class User < Recipient

    attr_reader :real_name
    def initialize(slack_id:,name:,real_name:)
      super(slack_id,name)
      @real_name = real_name
    end

    def self.list_all
      data = self.get("#{BASE_URL}users.list")
      users = []

      data["members"].each do |member|
        users << self.new(
          slack_id: member["id"], 
          name: member["name"], 
          real_name:member["profile"]["real_name"]
        )
      end 

      return users 
    end
    

  
  end
end