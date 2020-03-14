require_relative "test_helper"
require_relative "../lib/user"


describe "User class" do
  describe 'User instantiation' do
    before do
      @user = User.new(real_name: "Slackbot", status_text: "", status_emoji: "", slack_id: "CV5KNMDKN", name: "slack-cli")
    end
    
    it "is an instance of User" do
      expect(@user).must_be_kind_of User
    end

    it "is set up for specific attributes and data     types" do
      [:real_name, :status_text, :status_emoji, :slack_id, :name].each do |prop|
        expect(@user).must_respond_to prop
      end
      
      expect(@user.real_name).must_be_kind_of String
      expect(@user.name).must_be_kind_of String
      expect(@user.status_text).must_be_kind_of String
      expect(@user.slack_id).must_be_kind_of String
      expect(@user.status_emoji).must_be_kind_of String
    end
  end

  
  describe "self.get" do
    it "can get a list of users" do
      result = {}
      VCR.use_cassette("list-user-endpoint") do
        result = User.get("https://slack.com/api/users.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("list-user-endpoint") do
        expect {User.get("https://slack.com/api/bogus.call")}.must_raise SlackAPIError
      end
    end
  end

  describe "self.list_all" do
    it "returns a list of valid users" do
      result = []
      VCR.use_cassette("list-user-endpoint") do
        result = User.list_all
      end

      expect(result).must_be_kind_of Array
      expect(result.length).must_be :>, 0
      result.each do |item|
        expect(item).must_be_kind_of User
      end

    end
  end
end



  



  
  

