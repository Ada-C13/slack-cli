require_relative 'test_helper'

describe "Recipient class" do 

  describe "self.list_all" do 
    it "raises NotImplementedError" do 
      expect{Recipient.list_all}.must_raise NotImplementedError
    end 
  end 

  
  describe "Send Message" do 
    it "sends a message when a user and channel has been selected" do 
      VCR.use_cassette("sending-message") do 
        workspace = Workspace.new() 

        user = workspace.select_user("habenup")
        expect(user.send_message("Hello, again!", user)).must_equal true

        channel = workspace.select_channel("general")
        expect(channel.send_message("Hello, again!", channel)).must_equal true
      end 
    end 
    
    it "raises SlackApiError when given a wrong/bogus input" do 
      VCR.use_cassette("sending-message") do 
        user = Recipient.new(id: "LOL", name: "LMAO")
        
        expect{user.send_message("This is funny!!", user)}.must_raise SlackAPIError
      end 
    end 
  end 
end