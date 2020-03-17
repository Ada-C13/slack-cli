require_relative 'test_helper.rb'

describe 'Channel' do 
  describe 'constructor' do
    before do
      @channel = Channel.new("general", "W012A3CDE", "gen happenings", 3)
    end
    it 'creates channel, child of recipient' do
      expect(@channel).must_be_kind_of Channel
      expect(@channel.class.superclass).must_equal Recipient
    end
    it "has expected state" do
      expect(@channel.name).must_equal "general"
      expect(@channel.slack_id).must_equal "W012A3CDE"
      expect(@channel.topic).must_equal "gen happenings"
      expect(@channel.member_count).must_equal 3 
    end

  end

  describe "get_list" do
    before do
      VCR.use_cassette("Channel.get_list") do
        @channel_list = Channel.get_list
        @target_channel = @channel_list.find {|channel| channel.name == "random"}
      end
    end
    it "returns array" do
      expect(@channel_list).must_be_kind_of Array
      expect(@channel_list.empty?).must_equal false
      expect(@channel_list.first).must_be_kind_of Channel
    end

    it "has channel called Random" do
      expect(@target_channel).must_be_kind_of Channel
    end

    it "channel random has expected state" do
      expect(@target_channel.slack_id).must_equal "CVBCU0R37"
      expect(@target_channel.topic).must_equal "Non-work banter and water cooler conversation"
      expect(@target_channel.member_count).must_equal 1
    end

    xit "sends message" do 
      VCR.use_cassette("channel-post-success") do
        #test for failing POST is in  recipient  
        response = @target_channel.send("hello, from bot")
        expect(response["message"]["text"]).must_equal "hello, from bot"
      end
    end
  end

  describe "details" do
    it "displays correct details" do
      channel_list = Channel.get_list
      target_channel = channel_list.find {|channel| channel.name == "random"}
      target_a = ["random", "CVBCU0R37", "Non-work banter and water cooler conversation", 2]
      expect(target_channel.details).must_equal target_a
    end
  end
end