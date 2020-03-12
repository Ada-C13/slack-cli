require_relative 'user'
require_relative 'channel'

module SlackCli
  class Workspace
    attr_reader :users, :channels
    def initialize()
      @users = SlackCli::User.load_all
      @channels = []
    end #initialize
  end #class
end #module

test_workspace = SlackCli::Workspace.new
test_workspace.users.each do |user|
  puts user.real_name  
end