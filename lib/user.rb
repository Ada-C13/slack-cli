require 'table_print'

#module Slack 
  class User < Recipient
    attr_reader :real_name, :status_text, :status_emoji
  
    def initialize( real_name:, status_text:, status_emoji:, name:, slack_id:)
      super(user_id: user_id, user_name: user_name)
  
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end

    
      #tp workspace.users, :name,:real_name, :slack_id 
    
  end
#end
