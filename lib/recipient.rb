class Recipient
  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.get(sub_url)
    #when call gets all infomation from sub
    url = "https://slack.com/api/#{sub_url}?token=#{SLACK_TOKEN}&pretty=1"

    response = HTTParty.get(url)
    return response
  end
end
