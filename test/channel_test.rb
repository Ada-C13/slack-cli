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
    # TO DO: before block with cassette
    it "returns array" do
      VCR.use_cassette("Channel.get_list") do
        channel_list = Channel.get_list
        expect(channel_list).must_be_kind_of Array
        expect(channel_list.empty?).must_equal false
        expect(channel_list.first).must_be_kind_of Channel
      end
    end

    it "has channel called Random" do
      VCR.use_cassette("Channel.get_list") do
        channel_list = Channel.get_list
        target_channel = channel_list.find {|channel| channel.name == "random"}
        expect(target_channel).must_be_kind_of Channel
      end
    end

    it "channel SlackBot has expected state" do
      VCR.use_cassette("Channel.get_list") do
        channel_list = Channel.get_list
        target_channel = channel_list.find {|channel| channel.name == "random"}
        expect(target_channel.slack_id).must_equal "CVBCU0R37"
        expect(target_channel.topic).must_equal "Non-work banter and water cooler conversation"
        expect(target_channel.member_count).must_equal 1
      end
    end
  end

  describe "details" do
    it "displays correct details" do
      channel_list = Channel.get_list
      target_channel = channel_list.find {|channel| channel.name == "random"}
      target_a = ["random", "CVBCU0R37", "Non-work banter and water cooler conversation", 1]
      expect(target_channel.details).must_equal target_a
    end
  end
end