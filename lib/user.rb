require_relative 'recipient'

module Slack
  class User < Recipient

    attr_reader :real_name

    def initialize(id, name, real_name)
      
      super(id, name)

      @real_name = real_name ||= "Not specified"

    end

    def details
      tp self, "id", "name", "real_name"
    end

    def self.load_all
      list_results = HTTParty.get(BASE_URL + "users.list", query: {token: KEY})
      users_list = list_results["members"].to_a.map {
        |user| User.new(user["id"], user["name"], user["real_name"])
      }
      return users_list
    end

    def send_message(message)
      if message.class != String
        raise ArgumentError.new("Message: #{message} must be a string!")
      else
        HTTParty.post(BASE_URL + "chat.postMessage", query: {token: KEY, channel: @id, text: message})
      end
    end

  end
end