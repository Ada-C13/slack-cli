require_relative 'recipient'

class User < Recipient

  # Generator
  attr_reader :id, :name, :real_name, :status_text, :status_emoji

  # Constructor
  def initialize(id, name, real_name, status_text, status_emoji)
    @id   = id
    @name = name
    @real_name    = real_name
    @status_text  = status_text
    @status_emoji = status_emoji

    super(id, name)
  end

  # Return details for a user
  def details
    return "ID           = #{@id}\n" +
           "Name         = #{@name}\n" + 
           "Real Name    = #{@real_name}\n" + 
           "Status Text  = #{@status_text}\n" + 
           "Status Emoji = #{@status_emoji}"
  end

  # Get users from Slack
  def self.list_all
    result = Recipient.get("users.list")
    users  = []
    result["members"].each do |member|
      id           = member["id"]
      name         = member["name"]
      real_name    = member["real_name"]
      status_text  = member["profile"]["status_text"]
      status_emoji = member["profile"]["status_emoji"]
      users << User.new(id, name, real_name, status_text, status_emoji)
    end
    return users
  end

end # Class