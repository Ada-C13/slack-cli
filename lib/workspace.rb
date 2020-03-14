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
          return "You've selected #{selected.name}"
        end
      end
      return "Sorry, user not found"
    end

    def select_channel(search_term)
      @channels.each do |channel|
        if channel.name == search_term || channel.slack_id == search_term
          @selected = channel
          return "You've selected #{selected.name}"
        end
      end
      return "Sorry, channel not found"
    end

    def show_details
      if @selected == nil
        return "None selected – Please select a user or channel"
      else
        @selected.details
      end
    end

    # def send_message
    # end
  end
end
