require_relative "recipient"

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize#(topic:, member_count:, name:, slack_id:)
    super(name: name, id: id)
    @topic = topic
    @member_count = member_count
  end

  def self.create(identifier, identifier_type)
    recipient = Channel.new
    if identifier_type == "channel_name"
      recipient.name = identifier
    elsif identifier_type == "channel_id"
      recipient.id = identifier
    end
    return recipient
  end

  def details
  end

  #------ Class Methods ------

  #api endpoint https://api.slack.com/methods/conversations.list
  def self.list_all
  end

end