

class Recipient

  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  private

  # class method to build a url to send to HTTParty invoked in workspace initialize
  def self.get_all(sub_url) 
    url = "https://slack.com/api/#{sub_url}?token=#{SLACK_TOKEN}"
    response = HTTParty.get(url)
    
    return response
  end

  # def self.select

  # end

end