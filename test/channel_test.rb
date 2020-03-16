require_relative "test_helper"


describe "Channel Class" do
  before do
    VCR.use_cassette("new_channel") do
      @channel = SlackApi::Channel.new(slack_id: "CUT6XEYR0", topic: "For whatever it's worth!", name: "general", member_count: 5)
    end 
  end

  it "Creates an instance of Channel" do
    expect(@channel).must_be_kind_of SlackApi::Channel
    expect(@channel.slack_id).must_equal "CUT6XEYR0"
    expect(@channel.topic).must_be_kind_of String
    expect(@channel.topic).must_equal "For whatever it's worth!"
    expect(@channel.name).must_equal "general"
    expect(@channel.member_count).must_be_kind_of Integer
    expect(@channel.member_count).must_equal 5
  end
  
end
