require_relative 'recipient'


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
    
    
    def send_msg(message)
      resp = HTTParty.post(POST_URL, {
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: {
          token: TOKEN,
          channel: self.slack_id,
          text: message
        }
      })
      return resp.code == 200 && resp.parsed_response["ok"]
    end

  
  end
end