require 'httparty'
require_relative 'recipient'


module SlackCli
  class User < Recipient
    attr_accessor :real_name, :status_text, :status_text, :status_emoji

    def initialize(id, name, real_name, status_text = nil, status_emoji = nil)
      super(id, name)
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end #initialize

    #--------User Class Methods----------------------------
    #retrieves list of users from Slack
    #input
    #returns list of users [User]
    def self.load_all(url)
      users = []
      #send request to Slack API using users.list endpoint
      response = HTTParty.get(url) #request that will return the response
      #parse response and get users
        response['members'].each do |member|
          #create a user
          id = member["id"]
          name = member["name"]
          real_name = member["real_name"]
          status_text = member["profile"]["status_text"]
          status_emoji = member["profile"]["status_emoji"]
          #handle
          #real name
          slack_user = SlackCli::User.new(id, name, real_name, status_text, status_emoji)
          #save to users
          users.push(slack_user)
        end
      return users
    end #load_all method
  end #class
end #module
