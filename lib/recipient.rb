require "httparty"
require "dotenv"


Dotenv.load

BASE_URL = "https://slack.com/api/"
API_KEY = ENV["SLACK_API_TOKEN"]
USER_URL = "#{BASE_URL}/users.list"
CHANNEL_URL = "#{BASE_URL}/conversations.list"


class Recipient

attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name 
  end


  def details
    raise NotImplementedError, "Define this method in a child class"    
  end

  def self.get(url)
    data = HTTParty.get(url, query: { token: ENV["SLACK_API_TOKEN"]})

    #check for errors
    if data.code != 200 || data["ok"] == false
      raise SlackAPIError, "We encounter a problem: #{data["error"]}"
    end

    return data
  end

  def self.list_all
    raise NotImplementedError, "Define this method in a child class"
  end

  def send_message(message)
      HTTParty.post("https://slack.com/api/chat.postMessage", query: {
        token: ENV["SLACK_API_TOKEN"], 
        channel: self.slack_id, 
        text: message
      }
    )
  end 
 
  def set_user_profile_name(name)
    HTTParty.post("https://slack.com/api/users.profile.set?", query: {
      token: ENV["SLACK_API_TOKEN"], 
      profile: {display_name: name}.to_json,
      user: self.slack_id,
      }      
    )

    #File.open("bot-settings.json", "w") do |name|
    #  name.write(query.to_json)
    #end  
  end

  def set_user_profile_emoji(emoji)
    HTTParty.post("https://slack.com/api/users.profile.set?", query: {
      token: ENV["SLACK_API_TOKEN"], 
      profile: {status_emoji: emoji}.to_json,
      user: self.slack_id,
      }      
    )
    #File.open("bot-settings.json", "w") do |emoji|
    #  emoji.write(query.to_json)
    #end 
  end
end




class SlackAPIError < Exception  
end