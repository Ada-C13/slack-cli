require_relative 'recipient'

module SlackCli

    class User < Recipient

        attr_reader :slack_id, :name, :real_name, :status_text, :status_emoji

        def initialize(slack_id:, name:, real_name:, status_text:, status_emoji: nil)
            super(slack_id, name)
            @real_name = real_name
            @status_text = status_text
            @status_emoji = nil
        end

        def details
            return [{"slack_id" => slack_id,"name" => name ,"real_name" => real_name, "status_text" => status_text, "status_emoji" => status_emoji }]
        end

        def self.list_all
            url = "https://slack.com/api/users.list"
            param = {token: ENV["SLACK_API_TOKEN"]}
            result = self.get(url, param)
            user_list = result["members"].map { |user| SlackCli::User.new(slack_id: user["id"], name: user["name"], real_name: user["real_name"], status_text: user["status_text"], status_emoji: user["status_emoji"]) }
            return user_list
        end

    end
end
