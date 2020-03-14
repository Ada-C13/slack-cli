require_relative 'recipient'

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji, :all_users

  def initialize(slack_id, name, real_name, status_text, status_emoji)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
    # This list should include username, real name, and Slack ID.
    # response = HTTParty.get(BASE_URL, query: {token: API_KEY})
    # member = {}

    # response["members"].each do |member|
    #   if member["id"] == @slack_id
    #     @real_name = member["real_name"]
    #     @name = member["name"]
    #     @status_text = member["status_text"]
    #     @status_emoji = member["status_emoji"]
    #   end
    # end
  end

  # When I type list users, I should see a list of all the users in the Slack workspace
  def self.list_all
    response = self.get("users.list")
    all = []

    response["members"].each do |member|
      all << User.new(
        member["id"],
        member["name"],
        member["real_name"],
        member["profile"]["status_text"],
        member["profile"]["status_emoji"]
      )
    end
    
    return all
  end

end