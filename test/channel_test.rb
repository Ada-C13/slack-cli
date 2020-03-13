require_relative "test_helper"
describe "channel" do
  describe "self.get" do
    before do
      VCR.use_cassette("uses_get(url)") do
        @url = "https://slack.com/api/conversations.list"
        @response = Channel.get(@url)
      end
    end
    it "Uses .get method from the Recipient to get a channel object containing information about workspace channel" do
      expect(@response).must_be_instance_of HTTParty::Response
      expect(@response.code).must_equal 200
    end

    it "Should raise an Exception if the API search fails" do
      url = ""
      expect { Channel.get(url) }.must_raise Exception
    end
    #this is dependent on Slacks api
    it "Should return a list of all channels within the workspace" do
      expect(@response.parsed_response).must_be_kind_of Hash
      expect(@response["channels"].length).must_equal 3
    end
    it "Should have correct info for the first channel" do
      expect(@response["channels"][0]["name"]).must_equal "general"
      expect(@response["channels"][0]["id"]).must_equal "CV5GLCW12"
      expect(@response["channels"][0]["topic"]["value"]).must_equal "Company-wide announcements and work-based matters"
      expect(@response["channels"][0]["num_members"]).must_equal 5
    end
    it "Should have the correct info for the last channel" do
      expect(@response["channels"][-1]["name"]).must_equal "random"
      expect(@response["channels"][-1]["id"]).must_equal "CV86RT7AS"
      expect(@response["channels"][-1]["topic"]["value"]).must_equal "Non-work banter and water cooler conversation"
      expect(@response["channels"][-1]["num_members"]).must_equal 5
    end
  end
  describe "list_all" do
    before do
      VCR.use_cassette("list_all_channels") do
        @channel_list = Channel.list_all
      end
    end
    it "Should return an array of Channel objects" do
      expect(@channel_list).must_be_kind_of Array
      expect(@channel_list.length).must_be :>, 0
      @channel_list.each do |channel|
        expect(channel).must_be_instance_of Channel
      end
    end
  end
end
