require_relative 'test_helper'

describe 'User' do 
  describe 'constructor' do
    before do
      @user = User.new("Yaz", "W012A3CDE", "Yaz O'Shaughnessy")
    end
    it 'creates user, child of recipient' do
      expect(@user).must_be_kind_of User
      expect(@user.class.superclass).must_equal Recipient
    end
    it "has expected state" do
      expect(@user.name).must_equal "Yaz"
      expect(@user.slack_id).must_equal "W012A3CDE"
      expect(@user.real_name).must_equal "Yaz O'Shaughnessy"
    end

  end

  describe "details" do
    it "displays correct details" do
      user_list = User.get_list("user")
      target_user = user_list.find {|user| user.name == "slackbot"}
      target_a = ["slackbot", "USLACKBOT", "Slackbot" ]
      expect(target_user.details).must_equal target_a
    end
  end

  describe ".get_list" do
    # TO DO: before block with VCR cassette?
    it "returns array" do
      VCR.use_cassette("User.get_list") do
        user_list = User.get_list("user")
        expect(user_list).must_be_kind_of Array
        expect(user_list.empty?).must_equal false
        expect(user_list.first).must_be_kind_of User
      end
    end

    it "has user called SlackBot" do
      VCR.use_cassette("User.get_list") do
        user_list = User.get_list("user")
        target_user = user_list.find {|user| user.name == "slackbot"}
        expect(target_user).must_be_kind_of User
      end
    end

    it "user SlackBot has expected state" do
      VCR.use_cassette("User.get_list") do
        user_list = User.get_list("user")
        target_user = user_list.find {|user| user.name == "slackbot"}
        expect(target_user.slack_id).must_equal "USLACKBOT"
        expect(target_user.real_name).must_equal "Slackbot"
      end
    end
    
  end
end