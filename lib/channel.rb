require_relative "recipient"


class Channel < Recipient
  attr_reader :topic, :member_count
  
  def initialize(topic: nil, member_count: nil, slack_id:, name:)
    super(slack_id: slack_id, name: name)
    @topic = topic || {}
    @member_count = member_count || []
  end





  # def details

  # end

  # def self.list_all
  #   chanels = []
  #   query_parameters = {token: KEY}

  #   channels = HTTParty.get(CHANNAL_URL, query: query_parameters)

  #   channels["channels"].each do |chanel|
  #     chanels << chanel["name"]
  #   end
  #   return chanels
  # end



end

  