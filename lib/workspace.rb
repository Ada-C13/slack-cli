require_relative "user"
require_relative "channel"
require 'json'

class Workspace
  attr_reader :users, :channels
  attr_accessor :selected
  
  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = ""
  end

  def select_channel(input)
    select("channel", input)
  end

  def select_user(input)
    select("user", input)
  end

  # helper method for select_channel and select_user
  def select(type, input)
    instance_variable_get("@#{type}s").each do |item|
      if item.slack_id.upcase == input.upcase || item.name.upcase == input.upcase
        @selected = item
        break
      else 
        @selected = ""
      end
    end
  end

  def show_details
    return @selected == "" ? nil : @selected.details
  end

  # https://api.slack.com/methods/users.profile.set
  def customize_bot(username, emoji)
    response = HTTParty.post(BASE_URL + "users.profile.set", {
      headers: {
        "Content-Type": "application/json",
      },
      query: {
        token: TOKEN,
        profile: ({
          "display_name": username,
          "status_emoji": emoji
        }).to_json
      }
    })

    if response.code == 200 && response["ok"]
      # https://stackoverflow.com/questions/27163085/read-and-write-json-data-from-form-to-file
      # opens a file using the path provided
      # w+: Read-write - overwrites the existing file or creates new file if no file exists
      File.open("./lib/json/bot-settings.json", "w+") do |file| 
        # generates a JSON file from the argument provided (response) and writes it into the file
        file.write(JSON.generate(response))
      end
    else
      if response["error"] == "profile_status_set_failed_not_emoji_syntax"
        puts "Please try again, and use proper emoji syntax (:emoji_name:)"
      elsif response["error"] == "profile_status_set_failed_not_valid_emoji"
        puts "Please try again, #{emoji} is not in our library."
      else
        puts "#{response["error"]}"
      end
    end
  end

  # TODO: As a user, I can see a history of messages sent to the currently selected recipient. If I change recipients, the message list should also change.
  def message_history
  end
end