require_relative "recipient"
require "httparty"

class User < Recipient
  attr_reader :channels, :name, :id

  def initialize(name, id, channels = [])
    @channels = channels
    @name = name
    @id = id
  end

  BASE_URL = "https://slack.com/api/users.list?"
end
