require_relative 'test_helper'
require_relative '../lib/user'


describe "user" do
  describe "self.get" do
    it "receives response from the API call" do
      VCR.use_cassette("users_list_endpoint") do
        response = SlackCLI::User.get(USERS_URI, {token: SLACK_TOKEN})
        expect(response).must_be_instance_of HTTParty::Response
        expect(response["ok"]).must_equal true
        expect(response["members"]).wont_be_nil
        expect(response["members"]).must_be_instance_of Array
        expect(response["members"].length).wont_equal 0
      end
    end

    it "will raise an exception if the search fails" do
      VCR.use_cassette("users_list_endpoint") do
        #use the wrong keyword key instead of token
        expect{SlackCLI::Channel.get(USERS_URI, {key: SLACK_TOKEN})}.must_raise SlackCLI::SlackAPIError
        expect{SlackCLI::Channel.get(USERS_URI, {token: "XOXOSLACK"})}.must_raise SlackCLI::SlackAPIError
      end
    end
  end

  describe "self.list_all" do
    it "returns an array of User instances" do
      VCR.use_cassette("users_list_endpoint") do
        all_users = SlackCLI::User.list_all
        expect(all_users).must_be_instance_of Array
        expect(all_users.length).must_be :>, 0
        all_users.each do |user|
          expect(user).must_be_instance_of SlackCLI::User
          expect(user.slack_id).must_be_instance_of String
          expect(user.name).must_be_instance_of String
          expect(user.real_name).must_be_instance_of String
        end
      end
    end

    it "stores the members information in the User instance" do
      VCR.use_cassette("users_list_endpoint") do
        all_users = SlackCLI::User.list_all
        expect(all_users[0].slack_id).must_equal "USLACKBOT"
        expect(all_users[0].name).must_equal "slackbot"
        expect(all_users[0].real_name).must_equal "Slackbot"
      end
    end
  end

  describe "#get_details" do
    it "can get all the details of the user" do
      VCR.use_cassette("users_list_endpoint") do
        all_users = SlackCLI::User.list_all
        user01 = all_users[0]
        response = user01.get_details
        expect(response).must_equal true
      end
    end
  end
end
