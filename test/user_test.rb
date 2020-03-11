require_relative "test_helper"

describe "user" do

  describe "self.list_all" do
    it "returns an array of User instances" do
      VCR.use_cassette("users_list_endpoint") do
        all_users = User.list_all
        expect(all_users).must_be_instance_of Array
        all_users.each do |user|
          expect(user).must_be_instance_of User
          expect(user.slack_id).must_be_instance_of String
          expect(user.name).must_be_instance_of String
          expect(user.real_name).must_be_instance_of String
        end
      end
    end

    it "stores the members information in the User instance" do
      VCR.use_cassette("users_list_endpoint") do
        all_users = User.list_all
        expect(all_users[0].slack_id).must_equal "USLACKBOT"
        expect(all_users[0].name).must_equal "slackbot"
        expect(all_users[0].real_name).must_equal "Slackbot"
      end
    end
  end
end
