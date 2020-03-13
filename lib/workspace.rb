require 'HTTParty'
require 'dotenv'
require_relative 'slack'
require_relative 'channel'
require_relative 'user'
require_relative 'recipient'

Dotenv.load

class Workspace 

  attr_reader :users, :channels

  def initialize 
    @users = []
    @channels = []


  end

end