require_relative 'recipient.rb'
class User < Recipient
  attr_reader :real_name

  def initialize(name, slack_id, real_name)
    super(name, slack_id)
    @real_name = real_name
  end

  def details
    return super + [real_name]
  end

  def self.get_list(recipient_type)
    # why doesn't super.get_list("user") work here???
    response = Recipient.get_list(recipient_type)
    # Two errors with above and below:
    # NoMethodError - HTTParty::Response doesn't have a get_list method...WHAT? why does it think 
    # i'm calling get_list on response?? Because super.get_list returns a HTTParty::Response object? 
    # ArgumentError (expected 1, given 0) - when using super, i get this error even though I am passing
    # an argument. I quintuple checked my code for syntax errors but the error remained. 

    # Why doesn't the following line, with the commented-out, instantiated method below, work???
    # I'd like to have user's version of get_list be parameter-less.
    #response = self.get_list("user")
    list = []
    response.parsed_response["members"].each do |member|
      list << User.new(member["name"], member["id"], member["real_name"])
    end
    return list
  end

  # def self.get_list(recipient_type)
  #   return super.get_list(recipient_type)
  # end
end
