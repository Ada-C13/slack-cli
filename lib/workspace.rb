require 'httparty'
class Workspace
  attr_reader :users, :channels
  def initialize
    @users = []
    @channels = []
 
    url_1 = "https://slack.com/api/users.list"
    query = {
        token: ENV['SLACK_TOKEN']
    }
 
    response = HTTParty.get(url_1,query: query)
    @users = response["members"]
 
    # get channels

    url_2 = "https://slack.com/api/channels.list"

    
    response = HTTParty.get(url_2,query: query)
    @channels = response["channels"]
  

    
  end
  
  def select_channel

  end

  def select_user
  end

  def show_details
  end

  def send_message
  end
end

  
