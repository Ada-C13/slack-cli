require_relative "test_helper"
require_relative "../lib/channel"

describe "User class" do
  describe "initialize" do
    before do
      @chan_inst = Channel.new(
        name: "stuff",
        slack_id: "THISISANID",
        topic: "This is a channel to talk about stuff.",
        member_count: "3"
      )
    end
    it "is an instance of User" do
      expect(@chan_inst).must_be_kind_of Channel
    end
  end
  # Any tests involving a User should use the username SlackBot

  xdescribe "list_all" do
    it "creates an array of users" do
      VCR.use_cassette("list_users_endpoint") do
        users = User.list_all

        expect(users).wont_be :empty?
        expect(users).must_be_kind_of Array
        expect(users[0]).must_be_kind_of User
      end
    end

    xdescribe "self.get" do
      it "gets a list of users from the api" do
        list = {}
        VCR.use_cassette("list_users_endpoint") do
          list = User.get("https://slack.com/api/users.list")
        end
        
        expect(list).must_be_kind_of HTTParty::Response
        expect(list["ok"]).must_equal true
      end

      it "raises an error when the api call fails" do
        VCR.use_cassette("list_users_endpoint") do
          expect {User.get("https://slack.com/api/bogus.call")}.must_raise SlackAPIError
        end
      end
    end
  end
end


# Any tests involving a Channel should use the #random channel
