require 'httparty'
require 'dotenv'
require 'pry'
require 'table_print'

require_relative 'channel'
require_relative 'member'
Dotenv.load

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = Member.all
    @channels = Channel.all
  end

  def select_recipient (user_input)
    current_recipient = find_object(@users, user_input) || find_object(@channels, user_input)

    if current_recipient.nil?
      puts "Recipient does not exist"
    else
      puts "You have selected the current recipient: #{current_recipient.name}"
      return current_recipient
    end

  end
  
  def find_object(object_type, search_term)
    object_type.find {|object| 
      object.id == search_term || object.name == search_term}
  end

end