
class Workspace
  attr_reader :users, :channels
  attr_accessor :selected

  def initialize
    @users = []
    @channels = []
    @selected = [] #?
  end


  # def send_message
  #   if @selected is a channel
  #     @selected.send_message #but channel#send_message needs argument??
  #   elsif @selected is a users
  #     @selected.send_message #but channel#send_message needs argument??
  #   end
  # end
end