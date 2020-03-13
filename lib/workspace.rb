require 'httparty'
require 'dotenv'
require 'pry'
require 'table_print'

require_relative 'channel'
require_relative 'member'
Dotenv.load

class Workspace
  attr_reader :users, :channels

  ADD_CHANNEL_URL = 'https://slack.com/api/conversations.invite'
  TOKEN = ENV['USER_TOKEN']

  def initialize
    @users = Member.all
    @channels = Channel.all

    add_to_channel
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

  def add_to_channel
    list_of_bots = @users.map {|user| user.id if user.is_bot}
    
    @channels.each do |channel|
      list_of_bots.each do |bot|
        query_parameters = {
          token: TOKEN,
          channel: channel.id,
          users: bot
        }

        response = HTTParty.get(ADD_CHANNEL_URL, query: query_parameters)
      end
    end
  end

end