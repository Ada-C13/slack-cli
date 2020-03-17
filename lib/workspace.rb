require_relative "lib_helper.rb"
class Workspace

  attr_reader :users, :channels
  def initialize
    @users = User.get_list
    @channels = Channel.get_list
  end

  def select(recipient_kind, recipient_id)
    case recipient_kind
    when "user"
      return find(users, recipient_id)
    when "channel"
      return find(channels, recipient_id)
    else
      raise ArgumentError.new("Invalid recipient.")
    end
  end

  def print_list(recipient)
    case recipient
    when "users"
      tp users, {:name => {:display_name => "Username"}}, :slack_id, :real_name
    when "channels"
      tp channels, :name, :slack_id, :topic, :member_count
    else
      raise ArgumentError.new("Invalid recipient")
    end
  end

  def post(text, destination)
    compose_message(text, destination)
    response = HTTParty.post(BASE_URL + 'chat.postMessage', body: compose_message(text, destination))
    if !response["ok"]
      raise API_Error.new("#{response["error"]}")
    end
    return response
  end

  private
  def compose_message(text, destination)
    if !(destination.is_a? Recipient)
      raise ArgumentError.new("Not a valid recipient")
    end
    return post_param = {
      token: API_KEY,
      channel: destination.slack_id,
      text: text
    }
  end

  def find(recipient_kind, recipient_id)
    selected = recipient_kind.find {|recipient| recipient.name == recipient_id || recipient.slack_id == recipient_id}
    return selected
  end
 
end