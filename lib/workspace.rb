#coded along with Devin for Wave 1

require_relative 'user'
require_relative 'channel'
require 'dotenv'
Dotenv.load

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_user
    user_input = gets.chomp.upcase
    @users.each do |user|
      if (user.name.upcase || user.slack_id.upcase) == user_input
        @selected = user
        return @selected
      end
    end

    if @selected == nil
      raise SelectionError.new "The username or user id you entered is incorrect."
    end

  end

  def select_channel
    user_input = gets.chomp.upcase
    @channels.each do |channel|
      if (channel.name.upcase || channel.slack_id.upcase) == user_input
        @selected = channel
        return @selected
      end
    end

    if @selected == nil
      raise SelectionError.new "The channel name or user id you entered is incorrect."
    end
  end

  def show_details
    if @selected == nil
      puts "Unable to show details, as no recipient is selected."
      puts "\n\n"
    else 
      puts "The current recipient is: #{@selected.name}, #{@selected.slack_id}."
      puts "\n\n"
    end
  end

  def send_message
    if @selected == nil
      puts "Please select a recipient before attempting to send a messsage."
      puts "\n\n"
    else
      puts "Please enter your message: "
      message = gets.chomp
      @selected.send(message)
    end
  end
  
end

