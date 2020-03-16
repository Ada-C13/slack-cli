
module SlackCli

    class Recipient

        attr_accessor :slack_id, :name

        def initialize (slack_id, name)
            @slack_id = slack_id
            @name = name
        end

        def send_message(message)
            url = "https://slack.com/api/chat.postMessage"
            recipient = self.slack_id 
            token = ENV["SLACK_BOT_TOKEN"]
            message = HTTParty.post(url, query: {token: token, channel: recipient, text: message})
            return message["ok"] && message.code
        end

        def self.get(url, params)
            return HTTParty.get(url, query: params)
        end

        def self.list_all
        end

        def details
        end

    end

    
    class SlackAPIError < StandardError
    end


end

