# initialize should not take in any parameters
# Set @users and @channels to empty array. Eventually, these should be refactored so that they are arrays of users or arrays of channels

module Slack
  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = []
      @channels = []
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
