require_relative "test_helper"

#know need to to test intialize
describe "User Class" do
  before do
    VCR.use_cassette("user_list") do
      @user = User.list_users
    end
  end

  it "Test List Users Method " do
    #testing that we are return an Array
    #testing that we are return a channel array
    #test that the channel is count is an Integer
    expect(@user).must_be_kind_of Array
    expect(@user[0]).must_be_kind_of User
    expect(@user.length).must_be_kind_of Integer
  end
end
