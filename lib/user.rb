class User
  attr_reader :username, :real_name, :slack_id

  def initialize(slack_id:, username:, real_name:)
    @username = username
    @real_name = real_name
    @slack_id = slack_id
  end

end