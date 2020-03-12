require_relative "test_helper"

describe "initialize" do
  before do
    @channel = Channel.new("CUTE4M96W", "random", "random work-based matters", 5)
  end

  it "creates a new instance of Channel" do
    expect(@channel).must_be_kind_of Channel
    expect(@channel).must_respond_to :slack_id
    expect(@channel).must_respond_to :name
    expect(@channel).must_respond_to :topic
    expect(@channel).must_respond_to :member_count
  end

  it "stores an id" do
    expect(@channel.slack_id).must_equal "CUTE4M96W"
  end

  it "stores the channel's name" do
    expect(@channel.name).must_equal "random"
  end

  it "stores the channel's topic" do
    expect(@channel.topic).must_equal "random work-based matters"
  end

  it "stores the channel's member_count" do
    expect(@channel.member_count).must_equal 5
  end
end

describe "list_channels" do

  def build_test_workspace
    Workspace.new
  end

  it "returns an array of Channels" do
    VCR.use_cassette("list_channels") do
      workspace = build_test_workspace 
      channels = workspace.channels

      expect(channels).must_be_kind_of Array
    end
  end

  it "finds the channels" do
    VCR.use_cassette("list_channels") do
      workspace = build_test_workspace 
      channels = workspace.channels

      expect(channels).wont_be_nil
      expect(channels.length).must_equal 3

      # fix this so that it finds the first index value and last index value to spot check
      # expect(channels["channels"]).must_equal ["general", "api-testing", "random"]
    end
  end   
      
#     # it "will raise an exception if the search fails" do
#     #   VCR.use_cassette("location_find") do
#     #     location = ""
#     #     expect {
#     #       response = get_location(location)
#     #     }.must_raise SearchError
#     #   end
#     # end

#   it "lists the correct number of channel instances" do

#   end

#   it "lists the expected channels in the workspace" do
  
#   end

end