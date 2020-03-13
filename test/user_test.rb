require "test_helper"

describe "User Class" do
  before do
    @user = User.new(slack_id: "merlin_03", name: "Merlin", real_name: "Merlin Farmer")
  end
  describe "instantiation" do
    it "creates an instanse of User" do
      expect(@user).must_be_kind_of User
    end

    it "has @username" do
      expect(@user.name).must_equal "Merlin"
    end

    it "has real name" do
      expect(@user.real_name).must_equal "Merlin Farmer"
    end

    it "has Slack ID" do
      expect(@user.slack_id).must_equal "merlin_03"
    end
  end

  describe "get_details" do
    it "print a string" do
      expect(@user.get_details).must_be_kind_of String
    end

    it "string includes user's name, real name and Slack ID" do
      expect(@user.get_details.include? "merlin_03").must_equal true
      expect(@user.get_details.include? "Merlin").must_equal true
      expect(@user.get_details.include? "Merlin Farmer").must_equal true
    end
  end

  describe "self.load_all" do
    before do
      VCR.use_cassette("list_users_endpoint") do
        @result = User.load_all
      end
    end

    it "returns an Array" do
      expect(@result).must_be_kind_of Array
    end

    it "returns an array of Users" do
      expect(@result[0]).must_be_kind_of User
    end

    it "one of the users is Slackbot" do
      count = 0
      @result.each do |user|
        count += 1 if user.slack_id == "USLACKBOT"
      end
      expect(count).must_equal 1
    end
  end  
end