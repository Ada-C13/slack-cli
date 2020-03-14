require_relative 'user'
require_relative 'channel'

module Slack
  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = User.list
      @channels = Channel.list
      @selected = nil
    end

    # def select_channel()
    #   # acts on instance var array
    # end

    # def select_user()
    #   # acts on instance var array
    # end

    # def show_details
    #   # acts on instance var array
    # end

    # def send_message
    # end
  end
end
