require_relative 'recipient'

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji
  # attr_writer :status_text, :status_emoji
  def initialize(slack_id:, nickname:, real_name:, status_text: nil, status_emoji: nil)
    super(slack_id: slack_id, nickname: nickname)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end
  
  def details
    return "#{super}\nreal name: #{real_name}\nstatus: #{status_text}\nemoji:#{status_emoji}"
  end

  class << self
    def endpoint
      return "users.list"
    end

    def response_root
      return "members"
    end

    def make_from_record(record)
      new(
        slack_id: record["id"],
        nickname: record["name"],
        real_name: record["real_name"]
        )
    end

    def list_all
      super
    end  

  end
end