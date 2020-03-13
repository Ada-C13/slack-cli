require_relative 'channel'
require_relative 'user'

class Workspace

  attr_reader :users, :channels

  def intialize
    @users = []
    @channels = []

  end

  def list_channels
    url = "https://slack.com/api/channels.list"

    query_parameters = {
      token: ENV['SLACK_API_TOKEN']
    }

    response = HTTParty.get(url, query: query_parameters)

    # to do move this into recipient class
    channels = response["channels"].map do |channel|
      {:name => channel["name"],
      :topic => channel["topic"]["value"],
      :member_count => (channel["members"]).length,
      :slack_id => channel["id"]}
      # ["name"]
    end
    
    tp channels
  end

  def list_users
    url = "https://slack.com/api/users.list"

    query_parameters = {
      token: ENV['SLACK_API_TOKEN']
    }

  end
end