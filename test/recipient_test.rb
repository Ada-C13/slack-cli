require_relative 'test_helper'

describe "Recipient" do 
  before do 
    slack_id = "BUVMNKXU2"
    name = "north_end_fwends"
    @new_slack = SlackApp::Recipient.new(slack_id, name)
  end 
  it "is a class" do 
    expect(@new_slack).must_be_kind_of SlackApp::Recipient
  end 
  describe "Recipient self.get" do 
    it "self.get can load info with token" do 
      VCR.use_cassette("slack-recipient") do 
        url = "channels.list"
        response = SlackApp::Recipient.get(url)
        expect(response["ok"]).must_equal true 
      end 
    
    end 
  end 
end 



# describe SlackApiWrapper do
#   it "can send a valid message" do
#     VCR.use_cassette("slack-posts") do
#       response = SlackApiWrapper.send_msg("Hey I can post messages!", "general")
#       expect(response).must_equal true
#     end
#   end
# end