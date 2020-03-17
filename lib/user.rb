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

  def self.make_query
    return super("user")
  end

  def self.get_list
    response = self.make_query
    list = []
    response.parsed_response["members"].each do |member|
      list << User.new(member["name"], member["id"], member["real_name"])
    end
    return list
  end

end
