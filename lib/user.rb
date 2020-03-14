require 'table_print'

require_relative 'recipient'

#module Slack 
  class User < Recipient
    attr_reader :real_name, :status_text, :status_emoji
  
    def initialize #(real_name:, status_text:, status_emoji:, name:, slack_id:)
      super(id: id, name: name)
  
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end

    def self.create(identifier, identifier_type)
      recipient = User.new
      if identifier_type == "user_name"
        recipient.name = identifier
      elsif identifier_type == "user_id"
        recipient.id = identifier
      end
      return recipient
    end
  end
#end
