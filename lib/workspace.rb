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

    # def select_channel()
    #   # acts on instance var array
    # end

    # def show_details
    #   # acts on instance var array
    # end

    # def send_message
    # end
  end
end
