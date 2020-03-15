require_relative 'test_helper'


describe SlackCli::Channel do
  describe "Channel Class" do

    it "can generate all channels as a class" do
      VCR.use_cassette("conversations_list") do

        data = SlackCli::Channel.list_all
        
        expect(data[0]).must_be_instance_of SlackCli::Channel
      end
    end

    it "can send message to channel" do 

      VCR.use_cassette("conversations_list") do
        data = SlackCli::Channel.list_all
        response = data[0].send_msg("hey there!")
        expect(response).must_equal true 
      end 
      
    end
    
    it "can send fun message with message,emoji, name to show" do 
      VCR.use_cassette("conversation_list") do 
        data = SlackCli::Channel.list_all
        response = data[0].msg_emoji_name("hi there!",":bug","bug bot")
        expect(response).must_equal true 
      end 
    end 
    

    it "raise SlackAPIError if incorrect url" do 
      VCR.use_cassette("conversations_list") do

        expect{SlackCli::Channel.get("https://slack.com/api/wrong")}.must_raise SlackAPIError

      end 
    end 

  end 
end
