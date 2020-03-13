require 'pry'
require "httparty"
require "awesome_print"
require "dotenv"
require_relative 'recipient'
require_relative 'user'
require_relative 'channel'

module SlackCLI
  class Workspace
    attr_reader :users, :channels

    def initialize
      @users = SlackCLI::User.list_all
      @channels = SlackCLI::Channel.list_all
    end

    def select_user(input)
      selected = @users.select{|user| user.slack_id == input.upcase || user.name == input}
      return selected[0]
    end

    def select_channel(channel)
      selected = @channels.select{|channel| channel.slack_id == input.upcase || channel.name == input}
      return selected[0]
    end

    def show_details(selected)
      selected.details
    end

    def send_message
    end
  end
end
