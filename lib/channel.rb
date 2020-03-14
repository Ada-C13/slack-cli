require 'httpparty'

class channel<receiver 

  attr_reader :focus, :headcount

  def initialize(focus:, headcount:, name:, username:)
    @focus = focus
    @headcount = headcount
  end 

  def summary
    tp self, "username", "name", "focus", "headcount"
  end 

  
  def self.show_all 
    response = Channel.get("") # Revisit this and fill out later

    channels = []

    response["channels"].each do |i|
      channels << Channel.new(
        name: i["name"],
        username: i["username"],
        focus: i["focus"],
        headcount: i[""] #revisit this and fill out later 
      )
    end
    return channels
  end
end 

# If you customize the error handling, revisit this line and add necessary syntax 