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
      VCR.use_cassette("User.get_list") do
        user_list = User.get_list
        target_user = user_list.find {|user| user.name == "slackbot"}
        expect(target_user.details["real_name"]).must_equal "Slackbot"
      end
    end
  end

  describe ".get_list + send" do
    before do
      VCR.use_cassette("User.get_list") do
        @user_list = User.get_list
        @target_user = selected = @user_list.find {|recipient| recipient.name == "slackbot"}
      end
    end
    it "returns array" do
      expect(@user_list).must_be_kind_of Array
      expect(@user_list.empty?).must_equal false
      expect(@user_list.first).must_be_kind_of User
    end

    it "has user called SlackBot" do
      expect(@target_user).must_be_kind_of User
    end

    it "user SlackBot has expected state" do
      expect(@target_user.slack_id).must_equal "USLACKBOT"
      expect(@target_user.real_name).must_equal "Slackbot"
    end

    it "sends message" do 
      VCR.use_cassette("post-success") do
        #test for failing POST is in  recipient 
      end
    end
    
  end
end