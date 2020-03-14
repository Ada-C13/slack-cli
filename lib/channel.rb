require_relative "recipient"

class Channel < Recipient

  attr_reader :topic, :member_count

  def initialize( topic:, member_count:, name:, slack_id:)
    super(slack_id: slack_id, name: name)
    @topic = topic
    @member_count = member_count
  end

  def details
    tp self, "slack_id", "name", "topic", "member_count"
  end

  #------ Class Methods ------

  #api endpoint https://api.slack.com/methods/conversations.list
  def self.list_all
    #get the data
    response = Channel.get("https://slack.com/api/channels.list")

    #parse the data, instansiate an object
    channels = []

    response["channels"].each do |item|
      channels << Channel.new(
                name: item["name"],
                slack_id: item["id"],
                topic: item["topic"]["value"],
                member_count: item["num_members"]
      )
    end

    #return the list of instansiated objects
    #this format tells me that I can use this to instansiate a Workspace!
    return channels
  end

end