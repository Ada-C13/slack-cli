require 'httpparty'

class Receiver 

  attr_reader :username, :name

  def initialize(username:, name:)
    @username = username
    @name = name
  end 

  def give_slack(body_talk)
    response = HTTParty.post("", query: {token: ENV ['BOT_TOKEN'], channel: self.username, text: body_talk})

    unless response.code == 200 || response["ok"] != false
      raise ArgumentError.new("Whoops. We dropped the butter on the cat toy: #{clap_back["error"]}"
    end
    return clap_back
  end

  
  def self.show_all 
  end

end 

# If you customize the error handling, revisit this line and add necessary syntax 