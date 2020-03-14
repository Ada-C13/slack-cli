require_relative "test_helper"
require_relative "../lib/channel"

describe "Channel class" do
  describe 'Channel instantiation' do
    before do
      @channel = Channel.new(slack_id: "CV5KNMDKN", name: "slack-cli")
    end
    
    it "is an instance of Channel" do
      expect(@channel).must_be_kind_of Channel
    end

    it "is set up for specific attributes and data     types" do
      [:topic, :member_count, :slack_id, :name].each do |prop|
        expect(@channel).must_respond_to prop
      end
      
      expect(@channel.topic).must_be_kind_of Hash
      expect(@channel.name).must_be_kind_of String
      expect(@channel.member_count).must_be_kind_of Array
      expect(@channel.slack_id).must_be_kind_of String
    end
  end
end