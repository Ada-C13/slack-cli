require 'dotenv'
require 'httparty'
require_relative 'recipient'

Dotenv.load


class User < Recipient
  TOKEN        = ENV["SLACK_API_TOKEN"]
  SLACK_URL_UL = "https://slack.com/api/users.list"

  # Generator
  attr_reader :id, :name, :real_name, :status_text, :status_emoji

  # Constructor
  def initialize(id, name, real_name, status_text, status_emoji)
    @id = id
    @name = name
    @real_name    = real_name
    @status_text  = status_text
    @status_emoji = status_emoji
  end

  # Return details for a user
  def details
    return "ID = #{@id}, name = #{@name}, real name = #{@real_name}, status text = #{@status_text}, status emoji = #{@status_emoji}"
  end

  # Get users from slack
  def self.list_all
    query_parameters = { token: TOKEN }
    result = HTTParty.get(SLACK_URL_UL, query: query_parameters)

    unless result.code == 200
      raise RuntimeError, "Cannot talk to slack. HTTP code: #{result.code}"
    end
    
    unless result["ok"]
      raise RuntimeError, "Cannot talk to slack. Result is not ok."
    end

    users = []
    result["members"].each do |member|
      id           = member["id"]
      name         = member["name"]
      real_name    = member["real_name"]
      status_text  = member["profile"]["status_text"]
      status_emoji = member["profile"]["status_emoji"]
      users << User.new(id, name, real_name, status_text, status_emoji)
    end
    return users
  end

end # Class
