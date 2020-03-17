require_relative 'lib_helper'
#parent class for Channel and User 
class API_Error < StandardError
end
class Recipient
  attr_reader :name, :slack_id

  def initialize(name, slack_id)
    @name = name
    @slack_id = slack_id
  end

  def details
    return [name, slack_id]
  end

  # def compose(message, to_recipient)
  #   if message.class != String
  #     raise ArgumentError.new("Message must be string")
  #   end
  #   post_param = {
  #     token: API_KEY,
  #     text: message,
  #     channel: slack_id,
  #   }
  #   response = HTTParty.post(BASE_URL + 'chat.postMessage', body: post_param)
  #   if !response["ok"]
  #     raise API_Error.new("#{response["error"]}")
  #   end
  #   return response
  # end

  def self.make_query(recipient_kind)
    if recipient_kind != "user" && recipient_kind != "channel"
      raise ArgumentError.new("Not a valid recipient")
    end
    query_param = {token: API_KEY}
    response = HTTParty.get(BASE_URL + "#{recipient_kind}s.list", query: query_param)
    if !response["ok"]
      raise API_Error.new("#{response["error"]}")
    end
    return response
  end

end
