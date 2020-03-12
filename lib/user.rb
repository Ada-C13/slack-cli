require_relative 'recipient'

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji, :all_users

  def initialize(slack_id, name)
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
    response = HTTParty.get(BASE_URL + "users.list", query: QUERY)
    all_users = []

    response["members"].each do |member|
      all_users << {
        name: member["name"],
        real_name: member["real_name"],
        id: member["id"]
      } 
    end
    
    return all_users
  end

end