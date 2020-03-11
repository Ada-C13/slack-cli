require_relative 'recipient'

class Channel < Recipient
  attr_reader :name, :topic, :member_count, :id

  def initialize(name:,topic:,member_count:,id:)
    super(name, id)
    @topic = topic
    @member_count = member_count
  end

end