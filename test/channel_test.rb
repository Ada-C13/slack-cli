require_relative 'test_helper'

describe "Channel" do 
  before do 
    slack_id = "CUURD2M5Z"
    name = "slackcli"
    topic = ""
    member_count = "4"
    @new_channel = SlackApp::Channel.new(slack_id, name, topic, member_count)
  end 
  it "is a channel class" do 
    expect(@new_channel).must_be_kind_of SlackApp::Channel
  end 

  describe "self.list_all" do 
    it "self.load_all can load info with token" do 
      VCR.use_cassette("slack-channel") do 
        response = SlackApp::Channel.list_all
        expect(response["ok"]).must_equal true 
      end 
    end 
  end 

end 