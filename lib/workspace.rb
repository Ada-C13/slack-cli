require "httparty"
require "awesome_print"
require "dotenv"
require "colorized"
require_relative 'recipient'
require_relative 'user'
require_relative 'channel'

module SlackCLI
  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = SlackCLI::User.list_all
      @channels = SlackCLI::Channel.list_all
      @selected = selected
    end

    def select_user(input)
      selected_array = @users.select{|user| user.slack_id == input.upcase || user.name == input}
      if selected_array.empty?
        @selected = nil
      else
        @selected = selected_array[0]
      end
      return @selected
    end

    def select_channel(input)
      selected_array = @channels.select{|channel| channel.slack_id == input.upcase || channel.name == input}
      @selected = selected_array[0]
      return @selected
    end

    def show_details
      @selected.details
    end

    def send_message
    end
  end
end
