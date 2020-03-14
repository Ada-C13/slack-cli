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
    response = self.get("users.list", QUERY)
    all = []

    # if response.code != 200 || response[‘message’] != ‘success’
    #   raise IssLocationError, “API call failed with code #{response.code} and reason ’#{response[‘reason’]}”
    # end


    response["members"].each do |member|
      all << {
        name: member["name"],
        id: member["id"],
        real_name: member["real_name"]
      } 
    end
    
    return all
  end

end