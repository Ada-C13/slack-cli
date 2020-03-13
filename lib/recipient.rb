class Recipient
  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
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

class SlackAPIError < Exception
end
