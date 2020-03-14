require_relative 'test_helper'
require "./lib/recipient"

describe "Recipient" do
  before do 
    slack_id = "abcdefg123"
    name = "Jessica"
    @recipient = Recipient.new(slack_id, name)
  end

  describe "initialize" do
    it "can create a Recipient class" do
      expect(@recipient).must_be_kind_of Recipient
    end
  end

  describe "self.get" do
    it "should get correct details" do
      VCR.use_cassette("user-details") do
        response = @user.details
        expect(@user.real_name).must_equal "Slackbot"
        expect(@user.name).must_equal "slackbot"
      end
    end
  end

end
