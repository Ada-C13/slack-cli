require "httparty"
require "dotenv"
require "table_print"

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)
    url = "https://slack.com/api/chat.postMessage?token=#{SLACK_TOKEN}&channel=#{@slack_id}&text=#{message}"

    response = HTTParty.post(url)

    if response["ok"] != true || response.code != 200
      raise SlackError(("There was an error posting this message: #{response["error"]}"))
    else puts "Your message was sent successfully!"     end

    return response
  end

  def self.get(sub_url)
    # self calls only know about its self to call in another method
    # must call the (Class name).something
    # Recipent.get(querty) is called on the respective class that
    url = "https://slack.com/api/#{sub_url}?token=#{SLACK_TOKEN}&pretty=1"

    response = HTTParty.get(url)
    return response
  end
end

class SlackError < Exception
end
