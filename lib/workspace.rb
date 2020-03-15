require_relative 'user'
require_relative 'channel'

module Slack
  class Workspace

    attr_reader :users, :channels

    def initialize
      @users = Slack::User.load_all
      @channels = Slack::Channel.load_all
    end

    def select_user(user_selection)
      selected_user = @users.select {
        |user| user.name.downcase == user_selection.downcase || user.id == user_selection || user.real_name.downcase == user_selection.downcase
      }

      if selected_user[0] == nil
        raise ArgumentError.new("There is no user matching #{user_selection}.")
      end

      return selected_user[0]
    end

    def select_channel(given_channel)
      selected_channel = @channels.select {
        |channel| channel.name.downcase == given_channel.downcase || channel.id == given_channel
      }

      if selected_channel[0] == nil
        raise ArgumentError.new("There is no channel matching #{given_channel}.")
      end

      return selected_channel[0]
    end

  end
end