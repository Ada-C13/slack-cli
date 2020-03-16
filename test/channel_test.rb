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

  describe "self.get" do
    it "takes a method and returns HTTParty results" do
      VCR.use_cassette("list") do 
        result   = Recipient.get("conversations.list")
        expect(result).must_be_kind_of HTTParty::Response
        expect(result.code).must_equal 200
        expect(result["ok"]).must_equal true
      end
    end

    it "raises an error if the call fails" do
      VCR.use_cassette("fail") do 
        expect{ Recipient.get("fail.list") }.must_raise RuntimeError
      end
    end
  end # describe "self.get"

  # Get channels from slack
  describe "self.list_all" do
    it "returns an array of channels" do 
      VCR.use_cassette("list") do 
        channels = Channel.list_all
        expect(channels).must_be_kind_of Array
        expect(channels.size).must_be :>, 0
        channels.each do |channel|
          expect(channel).must_be_kind_of Channel
        end
      end
    end
  end # describe "self.list_all"

end # Class
