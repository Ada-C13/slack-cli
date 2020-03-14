require_relative "channel"
require_relative "user"

Dotenv.load

BASE_URL = "https://slack.com/api/conversations.list"


class WorkSpace
  attr_reader :users, :channels, :selected
  
  def initialize
    @users = []
    @channels = []
    @selected = nil
  end

  # def select_channels
  # end

  # def select_users
  # end

  # def show_details
  #   puts "I should see information about how many channels and users were loaded"
  #   input = gets.chomp.downcase
  # end

  # def send_message
  # end

end
  