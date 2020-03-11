class User < Recipient
  attr_reader :topic, :member_count

  def initialize
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
  end

    # When I type list users, I should see a list of all the users in the Slack workspace. This list should include username, real name, and Slack ID.

  def self.list_all
  end

end