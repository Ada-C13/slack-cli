require_relative 'lib_helper'
#template method for Channel and User 
class Recipient
  attr_reader :name, :slack_id

  def initialize(name, slack_id)
    @name = name
    @slack_id = slack_id
  end

  def self.get_list(recipient_kind)
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
class API_Error < StandardError
end