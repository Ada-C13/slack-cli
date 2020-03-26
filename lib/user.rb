require_relative 'recipient'

module SlackCli
  class User < Recipient

    attr_reader :real_name,:status_text, :status_emoji
    def initialize(slack_id:,name:,real_name:, status_text:, status_emoji:)
      super(slack_id,name)
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end

    def self.list_all
      data = self.get("#{BASE_URL}users.list")
      users = []

      data["members"].each do |member|
        users << self.new(
          slack_id: member["id"], 
          name: member["name"], 
          real_name: member["profile"]["real_name"],
          status_text: member["profile"]["status_text"],
          status_emoji: member["profile"]["status_emoji"]
        )
      end 

      return users 
    end
    

  
  end
end