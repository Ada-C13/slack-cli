require_relative 'test_helper'

describe "user class" do
  before do
    @user = Slack::User.new(234, "name", "real name")
  end

  describe "initialize" do
    it "can be created" do
      expect(@user.class).must_equal Slack::User
    end

    it "will hold all relevant variables" do
      expect(@user.name).must_equal "name"
      expect(@user.id).must_equal 234
      expect(@user.real_name).must_equal "real name"
    end

    it "will set the real name to 'not specified' if there is no real name set for that user" do
      no_topic_channel = Slack::User.new(2345, "name two", nil)
      expect(no_topic_channel.real_name).must_equal "Not specified"
    end
  end

  describe "user class methods" do
    it "can send a message to a user" do
      VCR.use_cassette("user") do
        users = Slack::User.load_all
        message = "this is a message!!!"
        response = users[5].send_message(message)
        expect(response["ok"]).must_equal true
      end
    end

    it "will raise an argument error if the message is not a string" do
      VCR.use_cassette("user") do
        users = Slack::User.load_all
        message = 1
        expect{users[5].send_message(message)}.must_raise ArgumentError
      end
    end
  end
end