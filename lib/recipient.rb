class Recipient
  attr_reader :name, :slack_id

  def initialize(name:, slack_id:)
    @name = name
    @slack_id = slack_id
  end

  def send_message(message:)
    response = HTTParty.post(POST_URL,
      query: {
        token: ENV['SLACK_TOKEN'],
        channel: slack_id,
        text: message
      }
    )
    return response.code == 200 && response.parsed_response["ok"]
  end

  def get_details
    raise NotImplementedError, 'Implement me in a child class!'
  end

  ###############
  # ClASS METHODS

  def self.get_api_data(url:)
    response = HTTParty.get(url, query: {token: ENV['SLACK_TOKEN']})
    if response.code != 200 || response["ok"] == false
      # rewrite (error while processing request?)
      raise SlackAPIError, "Request processing error: #{response["error"]}"
    end
    return response
  end

  def self.load_all
    raise NotImplementedError, 'Implement me in a child class!'
  end
end

class SlackAPIError < StandardError
end