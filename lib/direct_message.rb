require_relative "conversation"

module Slack
  class DirectMessage < Conversation
    
    def initialize(id, user)
      super(id)
      @type = :IM
      @user = user 
    end



  # CLASS METHODS


  # def self.get_all
    # TO-DO: implement when getting all 1-on-1 direct messages is necessary 
    # API endpoint https://slack.com/api/conversations.list  TYPES= "im"
  # end


  # def self.list_all 
    # TO-DO: implement when listing all 1-on-1 direct messages is necessary
  # end

  end
end