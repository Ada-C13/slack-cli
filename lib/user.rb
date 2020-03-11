require 'httparty'
require 'dotenv'
require 'table_print'
require_relative 'recipient'

Dotenv.load

class User < Recipient
  attr_reader :id,:name, :real_name, :status_text, :status_emoji

  USERS_URI = "https://slack.com/api/users.list"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]

  def initialize(slack_id = "", name = "", real_name = "", status_text = "", status_emoji = "")
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end


  def self.list_all
    response = User.get(USERS_URI,{token: SLACK_TOKEN})
   
    all_users = response["members"].map do |member|
      sleep(0.5)
      User.new(member["id"], member["name"], member["real_name"], member["profile"]["status_text"], member["profile"]["status_emoji"])    
    end
    # tp all_users, :slack_id, :name, :real_name

    return all_users
  end


  def self.print_all
    all_users = User.list_all
    tp all_users, :slack_id, :name, :real_name
  end
end

# can just use this in workspace or slack.rb #remember to require 'table_print'
# tp (User.list_all), :slack_id, :name, :real_name