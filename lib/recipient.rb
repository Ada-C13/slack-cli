require "httparty"

class Recipient # abstract class 

  attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end


  def send_message(msg_text)

  end

  def details
    raise NotImplementedError, "Implement me in a child class!"
  end

  # ----- CLASS METHODS -----

  # gets desired data from API 
  def self.get(url)
    requested_data = HTTParty.get(url, query: {token: ENV["BOT_TOKEN"]})

    if requested_data.code != 200 || requested_data["ok"] == false
      raise SlackAPIError, "Encountered error: #{requested_data["error"]}"
    end 

    return requested_data
  end


  def self.list_all
    raise NotImplementedError, "Implement me in a child class!"
  end

end

# create here so that it is accessible by all other classes in this project
class SlackAPIError < Exception
end