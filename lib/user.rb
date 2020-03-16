#coded along with Devin for Wave 1
require 'httparty'
require_relative 'recipient'

class User < Recipient
  attr_reader :real_name, :status_text

  def initialize(real_name:, status_text:, name:, slack_id:)
    super(slack_id: slack_id, name: name)

    @real_name = real_name
    @status_text = status_text
  end

  def details
    return [{
      "name" => @name, 
      "slack_id" => @slack_id,
      "real_name" => @real_name, 
      "status_text" => @status_text
      }]
  end

  def self.list_all
    data = self.get("https://api.slack.com/api/users.list")
    users = []
    
    data["members"].each do |user|
      users << User.new(
                  name: user["name"], 
                  slack_id: user["id"], 
                  real_name: user["profile"]["real_name"],
                  status_text: user["profile"]["status_text"] 
      )
    end
    
    return users
  end
end