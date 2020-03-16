require 'httparty'

require_relative 'workspace.rb'

module SlackCLI
  class Receiver 

    attr_reader :id, :name

    def initialize(id:, name:)
      @id = id
      @name = name
    end 

    def give_slack(body_talk)
      clap_back = HTTParty.post("https://slack.com/api/chat.postMessage", query: {token: ENV['BOT_TOKEN'], channel: self.id, text: body_talk})

      unless clap_back.code == 200 || clap_back["ok"] != false
        raise ArgumentError.new("Whoops. Someone dropped the butter on the cat toy: #{clap_back["error"]}")
      end
      return clap_back
    end

    def self.get_url(url)
      clap_back = HTTParty.get(url, query: {token: ENV['BOT_TOKEN']})

      unless clap_back.code == 200 || clap_back["ok"] != false
        raise ArgumentError.new("Whoops. Someone dropped the butter on the cat toy: #{clap_back["error"]}")
      end
      return clap_back
    end

    def self.show_all 
      # Just hanging out until my children need me
    end
  end 
end