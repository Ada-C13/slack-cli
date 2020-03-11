


class Recipient
  Dotenv.load

  BASE_URL = "https://slack.com/api/conversations.list"
  SLACK_ID = ENV["SLACK_TOKEN"]
  
  def send_message(message)
  
  end

  def self.get(uri, params)

  end
  
  def details(each)
    raise NotImplementedError, 'Implement me in a child class!'
  end

  def self.list_all(each)
    raise NotImplementedError, 'Implement me in a child class!'
  end

end