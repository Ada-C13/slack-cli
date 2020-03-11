require_relative "recipiant"
require 'httparty'
require 'dotenv'

Dotenv.load

BASE_URL = "https://slack.com/api/conversations.list"

class Channel < Recipiant
  attr_reader :topice, :member_count
  
  def initialize(topice, member_count)
    super(slack_id, name)
    @topice = topice
    @member_count = member_count
  end



  def details

  end

  def self.list_all

  end

end
  