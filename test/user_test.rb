require_relative "test_helper"

describe "User" do
  
  describe "Initialize" do

    before do
      @user = SlackCLI::User.new("pooper", "poop", "BUTHFRBNW")
    end

    it "can create an instance of User" do
      VCR.use_cassette("user_class") do
        expect(@user).must_be_kind_of SlackCLI::User
        expect(@user.name).must_equal "poop"
        expect(@user.username).must_equal "pooper"
        expect(@user.slack_id).must_equal "BUTHFRBNW"
      end
    end

    it "can load all users in User" do
      VCR.use_cassette("user_class") do
        expect(SlackCLI::User.load_all.length).must_equal 8
        expect(SlackCLI::User.load_all[0].name).must_equal "Slackbot"
      end
    end
  end
end