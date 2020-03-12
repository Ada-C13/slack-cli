require_relative "test_helper"

describe Channel do
  describe "self.list_all method" do
    it "list out all the channels info by calling self.list_all" do
      VCR.use_cassette("list_of_channels") do
        response = Channel.list_all
        expect(response.length).must_equal 3 
      end
    end
    it "must include #general the channel" do
      VCR.use_cassette("list_of_channels") do
        response = Channel.list_all
        expect(response[1][:channel_name]).must_equal "general"
      end
    end
  end
end