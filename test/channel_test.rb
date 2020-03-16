require_relative 'test_helper'
require_relative '../lib/channel'

describe SlackCli::Channel do
  describe "Channel" do
    describe "Channel Instantiation" do
        it "creates an instance of a Channel" do
          #create a known Channel
          test_Channel = SlackCli::Channel.new(1, "testname", "testtopic", "testmember_count")
          #expect a Channel
          expect(test_Channel).must_be_kind_of SlackCli::Channel
          expect(test_Channel.name).must_equal "testname"
        end

        it "validates Channel paramters" do
          expect{SlackCli::Channel.new(1, 12, "testtopic", "testmember_count")}.must_raise ArgumentError
        end
        
    end #instance of Channel

    describe "self.load_all Channels method" do
      it "returns a list all Channels" do
        url = ENV['BASE_URL'] + ENV['SUB_CHANNEL_URL'] + "token=" + ENV['SLACK_TOKEN']
        VCR.use_cassette("channel-details") do
          response = SlackCli::Channel.load_all(url)
          response.each do |channel|
            expect(channel).must_be_kind_of SlackCli::Channel
            expect(channel).must_respond_to :id
          end

          # make sure kate is in the Channels array
          channel_app = response.find_all { |channel| channel.id == "CV649DWUV" }
          expect(channel_app[0].name).must_equal "slack-api"
        end
      end  
    end
  end #class
end #modeul