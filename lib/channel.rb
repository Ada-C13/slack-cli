require_relative "recipiant"
require 'httparty'
require 'dotenv'

Dotenv.load

CHANNAL_URL = "https://slack.com/api/channels.list"
KEY = ENV["SLACK_TOKEN"]

class Channel < Recipiant
  attr_reader :topice, :member_count
  
  def initialize(topice, member_count)
    super(slack_id, name)
    @topice = topice
    @member_count = member_count
  end





  # def details

  # end

  # def self.list_all
  #   chanels = []
  #   query_parameters = {token: KEY}

  #   channels = HTTParty.get(CHANNAL_URL, query: query_parameters)

  #   channels["channels"].each do |chanel|
  #     chanels << chanel["name"]
  #   end
  #   return chanels
  # end



end

  