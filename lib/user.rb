require_relative "recipient"

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize( real_name:, status_text:, status_emoji:, name:, id:)
    super(id: id, name: name)

    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
    tp self, "slack_id", "name", "real_name"
  end


  #api endpoint documentation https://api.slack.com/methods/users.list
  def self.list_all
    #get the data
    response = User.get("https://slack.com/api/users.list")

    #parse the data, instansiate an object
    users = []

    response["members"].each do |item|
      users << User.new(
                name: item["name"],
                id: item["id"],
                real_name: item["real_name"],
                status_text: item["profile"]["status_text"],
                status_emoji: item["profile"]["status_emoji"]
      )
    end 
    return users  #return the list of instansiated objects
  end
end