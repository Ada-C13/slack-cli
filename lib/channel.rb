require_relative 'recipient'

class Channel < Recipient
  attr_reader :topic, :member_count
  def initialize(slack_id:, nickname:, topic:, member_count:)
    super(slack_id: slack_id, nickname: nickname)
    @topic = topic
    @member_count = member_count
  end
  
  def details
    return "#{super}\ntopic: #{@topic}\nmember_num: #{@member_count}"
  end

  class << self
    def endpoint
      return "conversations.list"
    end

    def response_root
      return "channels"
    end

    def make_from_record(record)
      new(
        slack_id: record["id"],
        nickname: record["name"],
        topic: record.dig("topic", "value"),
        member_count: record["num_members"])
    end

    def list_all
      super
    end
  end
end