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
      @selected = nil
    end

    def select_user(input)
      select(@users, input)
    end

    def select_channel(input)
      select(@channels, input)
    end

    def show_details
      return @selected.details
    end

    def send_message(message)
      return @selected.send_message(message)
    end

    def select(recipients, input)
      selected_array = recipients.select{|recipient| recipient.slack_id == input.upcase || recipient.name == input}
      if selected_array.empty?
        return nil
      end
        @selected = selected_array[0]
      return @selected
    end
  end
end
