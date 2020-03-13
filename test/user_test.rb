require_relative 'test_helper.rb'

describe "User" do
  it "can initialize user with slack id" do
    skip
  end

  it "can list all users" do
    VCR.use_cassette("self.list_all") do

      response = User.list_all

      expect(response).must_be_kind_of Array
      expect(response[0]).must_be_kind_of Hash
      expect(response[0][:username]).must_be_kind_of String
      expect(response[0][:real_name]).must_be_kind_of String
      expect(response[0][:slack_id]).must_be_kind_of String

      slack_bot = response.find{ |user| user[:username] == "slackbot"}
      expect(slack_bot[:username]).must_equal "slackbot"
      expect(slack_bot[:real_name]).must_equal "Slackbot"
    end

  end


end