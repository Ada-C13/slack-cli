require "test_helper"

describe "User Class" do
  describe "Instantiation" do
    before do
      @user = User.new(slack_id: "merlin_03", username: "Merlin", real_name: "Merlin Farmer")
    end
    it "creates an instanse of User" do
      expect(@user).must_be_kind_of User
    end

    it "has @username" do
      expect(@user.username).must_equal "Merlin"
    end

    it "has real name" do
      expect(@user.real_name).must_equal "Merlin Farmer"
    end

    it "has Slack ID" do
      expect(@user.slack_id).must_equal "merlin_03"
    end
  end
end