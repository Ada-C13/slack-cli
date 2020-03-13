require_relative 'test_helper'

describe "class Channel < Recipient" do

  before do
    @id      = "CV5S4LJPN"
    @name    = "general"
    @topic   = "Company-wide announcements"
    @member_count = 8
    @channel = Channel.new(@id, @name, @topic, @member_count)
  end # before

  # Constructor
  describe "constructor" do
    it "takes id, name, topic, member_count" do
      expect(@channel).must_be_kind_of Channel
      expect(@channel.id).must_equal @id
      expect(@channel.name).must_equal @name
      expect(@channel.topic).must_equal @topic
      expect(@channel.member_count).must_equal @member_count
    end
  end # describe "constructor"

  # Return details for a channel
  describe "details" do
    it "returns a string" do
      expect(@channel.details).must_be_kind_of String
    end
  end # describe "details"

  # Get channels from slack
  describe "self.list_all" do
    it "returns an array of channels" do 
      VCR.use_cassette("channel_list") do 
        channels = Channel.list_all
        expect(channels).must_be_kind_of Array
        channels.each do |channel|
          expect(channel).must_be_kind_of Channel
        end
      end
    end
  end # describe "self.list_all"

end # Class
