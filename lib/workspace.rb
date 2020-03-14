class Workspace    
  attr_reader :users, :channels, :chosen

  def initialize
    @users = []
    @channels = []
    @chosen = nil
  end

  def choose_channel 
    sought = gets.chomp

    channels.each do |channel|
      

  end

  def choose_user
    #make this method 
  end 


  def show_summary
    #make this method
  end

  def send_talk
    #make this method
  end 

end