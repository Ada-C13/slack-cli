require_relative 'test_helper'
require "./lib/user"

describe "Recipient" do
  before do 
    slack_id = "USLACKBOT"
    @user = User.new(slack_id)
  end

  describe "initialize" do
    it "can create a User class" do
      expect(@user).must_be_kind_of User
    end
  end

  describe "details" do
    it "should update to correct details" do
      VCR.use_cassette("user-details") do
        response = @user.details
        expect(@user.real_name).must_equal "Slackbot"
        expect(@user.name).must_equal "slackbot"
      end
    end  
  end


  describe "self.list_all" do
    # loop through each user

  end

end
