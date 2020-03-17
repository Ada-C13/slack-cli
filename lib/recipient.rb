require_relative 'lib_helper'
#template method for Channel and User 
class API_Error < StandardError
end
class Recipient
  attr_reader :details
  attr_accessor :messages
  def initialize(name, slack_id)
    @details = {
      "name" => name,
      "id" => slack_id
    }
    @messages = {}
  end

  def name
    return @details["name"]
  end

  def slack_id
    return @details["id"]
  end

  def self.make_query(recipient_kind)
    if recipient_kind != "user" && recipient_kind != "channel"
      raise ArgumentError.new("Not a valid recipient")
    end
    response = HTTParty.get(BASE_URL + "#{recipient_kind}s.list", query: QUERY_PARAM)
    if !response["ok"]
      raise API_Error.new("#{response["error"]}")
    end
    return response
  end

end
