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
    find_object(@users, user_input) || find_object(@channels, user_input)
  end
  
  def find_object(object_type, search_term)
    object_type.find {|object| 
      object.id == search_term || object.name == search_term}
  end

end