require_relative "test_helper"

describe "Channel class" do 
  # describe "#initialize" do 
  # end 

  describe "self.get" do 
    it "returns a response of channels list from API" do 
      VCR.use_cassette("find_channel_list") do 
        url = "https://slack.com/api/channels.list"
        query = {
          token: ENV["SLACK_TOKEN"]
        }

        response = Slack::Channel.get(url, query)

        expect(response["ok"]).must_equal true
      end 
    end
  end 


  describe "self.list_all" do 
    it "creates and returns instances of channels" do 
      VCR.use_cassette("make_channel_list") do 
        channel_list = Slack::Channel.list_all

        expect(channel_list).must_be_kind_of Array

        channel_list.each do |channel|
          expect(channel).must_be_kind_of Slack::Channel 
        end 
      end 
    end 
  end 
end 