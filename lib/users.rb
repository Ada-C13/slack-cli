#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'

require_relative 'recipient.rb'

Dotenv.load

module SlackCLI
  class User < Recipient
    attr_reader :username, :name, :slack_id

    def initialize(username, name, slack_id)
      super(slack_id)
      @name = name
      @username = username
    end

    def self.load_all 
      response = SlackCLI::Recipient.get_response("users.list")
      all_users = []
      #p response
      response["members"].each do |member|
        username = member["name"]
        name = member["real_name"]
        slack_id = member["id"]

        all_users << SlackCLI::User.new(username, name, slack_id)
      end
      return all_users
    end
  end
end