require_relative "channel"
require_relative "user"
require_relative "recipiant"
require 'httparty'
require 'dotenv'

Dotenv.load

BASE_URL = "https://slack.com/api/conversations.list"

class WorkSpace
  attr_reader :users, :channels
  
  def initialize
    @users = []
    @channels = []
  
  end

  # def select_channels
  # end

  # def select_users
  # end

  # def show_details
  # end

  # def send_message
  # end

end
  