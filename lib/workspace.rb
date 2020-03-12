require 'pry'
require "httparty"
require "awesome_print"
require "dotenv"
require_relative 'workspace'
require_relative 'recipient'
require_relative 'user'
Dotenv.load

module SlackCLI
  class Workspace
    attr_reader :users, :channels

    def initialize
      @users = SlackCLI::User.list_all
      @channels = []
    end

    def select_user
    end

    def select_channel
    end

    def show_details
    end

    def send_message
    end
  end
end
