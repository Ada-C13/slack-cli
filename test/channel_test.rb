require_relative 'test_helper'


describe SlackCli::Channel do
  describe "Channel Class" do

    it "can generate all channels as a class" do
      VCR.use_cassette("slack-posts") do

        data = SlackCli::Channel.get_all
        
        expect(data[0]).must_be_instance_of SlackCli::Channel
      end
    end

    it "can send message to channel" do 

      VCR.use_cassette("slack-posts") do
        data = SlackCli::Channel.get_all
        response = data[0].send_msg("hey there!")
        expect(response).must_equal true 
      end 
      
    end 

  end 
end
