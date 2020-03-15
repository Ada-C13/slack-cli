class User < Recipient
  attr_reader :name, :real_name, :slack_id, :time_zone

  def initialize(name:, real_name:, slack_id:, time_zone:)
    super(name: name, slack_id: slack_id)
    @real_name = real_name
    @time_zone = time_zone == nil ? "not set" : time_zone
  end

  def get_details
    return "#{name} --> real name: #{real_name} | Slack ID: #{slack_id} | time zone: #{time_zone}"
  end

  ###############
  # CLASS METHODS

  def self.load_all
    response = User.get_api_data(url: USERS_URL)
    users = response["members"].map do |user|
      User.new(
        slack_id: user["id"],
        name: user["name"],
        real_name: user["profile"]["real_name"],
        time_zone: user["tz"]
      )
    end
  end
end