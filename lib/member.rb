require_relative 'recipient'

class Member < Recipient
  attr_reader :name, :real_name, :id

  def initialize(name:,real_name:,id:)
    super(name, id)
    @real_name = real_name
  end
  
end