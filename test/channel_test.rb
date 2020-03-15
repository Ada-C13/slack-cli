require_relative 'test_helper'

describe "channel class" do
  before do
    @channel = Slack::Channel.new(234, "name", "topic", 3)
  end

  describe "initialize" do
    it "can be created" do
      expect(@channel.class).must_equal Slack::Channel
    end

    it "will hold all relevant variables" do
      expect(@channel.name).must_equal "name"
      expect(@channel.id).must_equal 234
      expect(@channel.num_members).must_equal 3
      expect(@channel.topic).must_equal "topic"
    end

    it "will set the topic to 'no topic' if there is no topic set for that channel" do
      no_topic_channel = Slack::Channel.new(2345, "name two", nil, 4)
      expect(no_topic_channel.topic).must_equal "No topic"
    end
  end

  describe "channel methods" do
    it "can send a message in a channel" do
      VCR.use_cassette("channel") do
        channels = Slack::Channel.load_all
        message = "this is a message!!!"
        response = channels[0].send_message(message)
        expect(response["ok"]).must_equal true
      end
    end

    it "will raise an argument error if the message is not a string" do
      VCR.use_cassette("channel") do
        channels = Slack::Channel.load_all
        message = 1
        expect{channels[0].send_message(message)}.must_raise ArgumentError
      end
    end
  end

end