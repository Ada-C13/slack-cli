require "httparty"
require "dotenv"
require "awesome_print"

require_relative "recipient"
require_relative "channel"
require_relative "user"

class Workspace

  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all # arrays of users
    @channels = Channel.list_all # arrays of channels
    @selected = ""
  end

  def select_user(user_id_or_username)
    if @users.any? {|user| user.slack_id == user_id_or_username || user.name == user_id_or_username}
      @selected = user_id_or_username
    else 
      p "User doesn't exist!"
    end
  end

  def show_details(lists) # array of objects
    return lists.select {|list| list.slack_id == @selected || list.name == @selected}
  end

  def prompt_options
    puts "6 options: list users, list channels, select user, select channel, details, or quit:"
    input = gets.chomp.downcase
    return input
  end
end