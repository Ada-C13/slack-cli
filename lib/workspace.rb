# This is the driver code
require 'httparty'
require 'dotenv'
require 'pry'
require 'table_print'

Dotenv.load

module SlackApi
  class Workspace
    attr_reader :users, :channels

    def initialize(

    )

      get_channels_from_api
      get_users_from_api

      # @selected = selected

    end # initialize end

    BASE_URL = "https://slack.com/api/"


    def get_users_from_api
      query_parameters = {
        token: ENV["SLACK_TOKEN"]
      }
       endpoint = BASE_URL + "users.list"

       response = HTTParty.get(endpoint, query: query_parameters)
       @users = response["members"].map do |member|

        User.new(slack_id: member["id"], name: member["name"], real_name: member["real_name"])
       end



    end

# ###################################################################


    def get_channels_from_api
      query_parameters = {
        token: ENV["SLACK_TOKEN"]
      }

    endpoint = BASE_URL + "channels.list"
      # This list should include the channel's name, topic, member count, and Slack ID.
      response = HTTParty.get(endpoint, query: query_parameters)
        @channels = response["channels"].map do |channel|
        Channel.new(slack_id: channel["id"], name: channel["name"],
        member_count: channel["members"].length, topic: channel["topic"]["value"])
        end
    end

# #############################################################################

    def list_all_users
      tp @users
      return
     
    end


    # #############################################################################

    def list_all_channels
      tp @channels
      return 
    end
      
      

   


    # def select_user
    # end
    
    # def select_channel
    # end
    
    # def show_details
    # end
    
    # def send_msg
    # end

  end # class end
  
end # module end









