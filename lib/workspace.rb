require 'dotenv'
require 'httparty'
require_relative 'user'
require_relative 'channel'

# YOU HAD YOUR SLACK TOKEN HERE, BUT YOU DELETED IT BECAUSE YOU DON'T NEED IT IN WORKSPACE AT THIS POINT

# IT IS NOW LISTED IN RECIPIENT

class Workspace
  attr_reader :users, :channels, :selected
  
  def initialize
    @users = User.list_users # will be array of user objects
    @channels = Channel.list_channels # will be array of channel objects
    @selected = nil # will be current instance of selected user or channel to STORE IT so the user can: display details or send message
  end

  
  # def select_channel
  
  # end
  
  
  # def select_user
  
  # end
  
  
  # def show_details
  
  # end
  
  
  # def send_message
  
  # end
  
end

# def self.load_all(full_path: nil, directory: nil, file_name: nil)
#   full_path ||= build_path(directory, file_name)

#   return CSV.read(
#     full_path,
#     headers: true,
#     header_converters: :symbol,
#     converters: :numeric
#   ).map { |record| from_csv(record) }
# end

# private

#   def self.load_all
#   response = Recipient.get_response("channels.list")
#   all_channels = []
#   response["channels"].each do |channel|
#     name = channel["name"]
#     topic = channel["topic"]["value"]
#     member_count = channel["members"].length
#     slack_id = channel["id"]
#     all_channels << SlackCLI::Channel.new(name, topic, member_count, slack_id)
#   end
#   return all_channels
# end