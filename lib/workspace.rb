  # create, call, and use User stuff and Channel stuff from here
  # but User stuff and Channel stuff are defined in their own clases

  class Workspace

    attr_reader :users, :channels
  
    def initialize
      @users = []
      @channels = []
    end
  
    # https://slack.com/api/channels.list?token=xoxb-849152884562-991856830644-R4zMDoqle5Oit0jOZ18fAeNq&pretty=1
  
  # def test
  #   url = "https://slack.com/api/channels.list?token=#{SLACK_TOKEN}&pretty=1"
  #   response = HTTParty.get(url)
  
  #   # { 
  #   #   "Our_channels" => {
  #   #   :id => response[0]["id"],
  #   #   :name => response[0]["name"]
  #   #   }
  #   # }
  
  #   p response
  # end
  # p test
  
  end