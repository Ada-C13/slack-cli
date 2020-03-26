require_relative 'recipient'

module SlackApi
  class Channel < Recipient

    attr_reader  :topic, :member_count, :slack_id, :name

    def initialize(
     slack_id:, 
     name:, 
     topic:,
     member_count:
    )

    super(slack_id: slack_id, name: name)

      @topic = topic
      @member_count = member_count
    end 
    
    def show_details
    end

# ################# Class Methods ########################

    # https://api.slack.com/methods/conversations.list
    def self.list_all
      # This method exists in Class Workspace. 
    end

  end 
  
end 














