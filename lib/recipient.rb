require 'httparty'
require 'dotenv'
require 'pry'
require 'table_print'

Dotenv.load

class Recipient
  attr_reader :name,:id

  def initialize(name,id)
    @name = name
    @id = id
  end
  
end