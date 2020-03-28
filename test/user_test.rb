require_relative "test_helper"


describe "User Class" do
  before do
    VCR.use_cassette("new_user") do
      @user = SlackApi::User.new(slack_id: "CUT6XEYR0", real_name: "char", name: "monkey")
    end 
  end

  it "Creates an instance of User" do
    expect(@user).must_be_kind_of SlackApi::User
    expect(@user.slack_id).must_equal "CUT6XEYR0"
    expect(@user.real_name).must_be_kind_of String
    expect(@user.name).must_equal "monkey"
  end

end 