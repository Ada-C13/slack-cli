
module Slack_cli
  class Workspace
    attr_reader :users, :channels
  
    def initialize
      @users = []
      @channels = []
    end
  end
end
