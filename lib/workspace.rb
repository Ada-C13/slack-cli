require_relative "user"
require_relative "channel"

module Slack
  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = User.list
      @channels = Channel.list
      @selected = nil
    end

    def select_user(search_term)
      @users.each do |user|
        if user.name == search_term || user.slack_id == search_term
          @selected = user
          return "You've selected #{selected.name}".green
        end
      end
      return "Sorry, user not found".red
    end

    def select_channel(search_term)
      @channels.each do |channel|
        if channel.name == search_term || channel.slack_id == search_term
          @selected = channel
          return "You've selected #{selected.name}".green
        end
      end
      return "Sorry, channel not found".red
    end

    def show_details
      @selected.details
    end

    def send_message(text)
      @selected.send_message(text)
    end
  end
end
