require_relative "test_helper"
require_relative "../lib/channel"

describe "Channel" do
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
    before do
      VCR.use_cassette("workspace_initialize") do
        @workspace = Workspace.new
      end
    end

    it "returns an array of Channels" do
      channels = @workspace.channels

      expect(channels).must_be_kind_of Array
    end

    it "finds the channels" do
      channels = @workspace.channels

      expect(channels).wont_be_nil
      expect(channels.length).must_equal 3

      # fix this so that it finds the first index value and last index value to spot check
      # expect(channels["channels"]).must_equal ["general", "api-testing", "random"]
    end
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

# _____ FROM ZOOM with Devin

#   describe "Channel" do
#     describe "self.get" do
#       it "gets a list of channels and returns them as an HTTParty Response" do
#         result = {}
#         VCR.use_cassette("channels-list-endpoint") do
#           result = Channel.get("https://slack.com/api/channels.list")
#         end

#         expect(result).must_be_kind_of HTTParty::Response
#         expect(result["ok"]).must_equal true
#       end

#       it "raises an error when a call fails" do
#         VCR.use_cassette("channels-list-endpoint") do
#           expect {Channel.get("https://slack.com/api/bogus.endpoint")}.must_raise SlackAPIError
#         end
#       end
#     end

#     describe "self.list" do
#       it "returns a valid list of the channels" do
#         result = []

#         VCR.use_cassette("channels-list-endpoint") do
#           result = Channel.list_all
#         end

#         expect(result).must_be_kind_of Array
#         expect(result.length).must_be :>, 0
#         result.each do |channel|
#           expect(channel).must_be_kind_of Channel
#         end

#       end
#     end
#   end
# end
