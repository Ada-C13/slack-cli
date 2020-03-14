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

    # it 'Keep treck of topice' do
    #   topice = {}
    #   member_count = []
    #   channel = Channel.new(topic, member_count, name, slack_id)
    #   channel.must_respond_to :topice
    #   expect(channel.topice).must_be_kind_of Hash
    # end

    # it 'Keep treck of slack member_count' do
    #   topice = {}
    #   member_count = []
    #   channel = Channel.new((topic, member_count, name, slack_id)
    #   channel.must_respond_to :member_count
    #   expect(channel.member_count).must_be_kind_of Array
    # end
  end
end