require_relative 'recipient.rb'
require 'dotenv'
require 'httparty'

Dotenv.load

class User < Recipient
  attr_reader :slack_id, :real_name, :status_text, :status_emoji, :name
  def initialize(slack_id:, real_name:, status_text:, status_emoji:, name:)
    @slack_id = slack_id
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
    @name = name    
  end

  def details
    return [{"name" => @name, "real_name" => @real_name, "status text" => @status_text, "status emoji" => @status_emoji, "slack_id" => @slack_id}]
  end

  def self.list_all
    url = "https://slack.com/api/users.list"
    params = {
        token: ENV['SLACK_TOKEN'],
      }
      response = self.get(url,params)
      array_of_users = []
      response["members"].each do |user|
        array_of_users.push(User.new(slack_id: user["id"], real_name: user["real_name"], status_text: user["profile"]["status_text"], status_emoji: user["profile"]["status_emoji"], name: user["name"]))
      end

    return array_of_users
  end

end