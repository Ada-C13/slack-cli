require_relative 'recipient'

class Channel < Recipient

  def initialize(slack_id,name,topic,member_count)
    super(slack_id,name)
    @topic = topic 
    @member_count = member_count
  end  

  
end