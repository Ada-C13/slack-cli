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

    
  end
#end
