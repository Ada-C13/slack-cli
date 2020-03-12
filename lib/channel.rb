class Channel < Recipient
  attr_reader :topic, :member_count
  def initialize (slaci_id, name, topic, member_count)
    super(slack_id,name) # need to double check this
    @topic = topic
    @member_count = member_count
  end

  def details
  end

  def self.list_all
  end
end