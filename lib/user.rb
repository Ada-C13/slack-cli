class User < Recipient
  attr_reader :name, :real_name, :slack_id

  def initialize(name:, real_name:, slack_id:)
    super(name: name, slack_id: slack_id)
    @real_name = real_name
  end

  def get_details
    return "#{name} => real name: #{real_name}, Slack ID: #{slack_id}"
  end

end