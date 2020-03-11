require_relative 'test_helper'


describe SlackCli::Channel do
  describe "Channel Class" do

    it "can generate all channels as a class" do
      VCR.use_cassette("slack-posts") do

        data = SlackCli::Channel.get_all
        
        expect(data[0]).must_be_instance_of SlackCli::Channel
      end
    end

  end 
end
