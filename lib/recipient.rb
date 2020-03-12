require "httparty"
require "dotenv"
require "awesome_print"

Dotenv.load

class Recipient
  
  attr_reader :id, :name

  def initialize(id, name) # (string, sting)
    @id = id
    @name = name
  end

  # to list all the users and channels
  def self.list_all
    raise NotImplementedError, 'Implement me in a child class!'
  end

  def self.get(url, params)
    return response = HTTParty.get(url, query: params)
  end

end