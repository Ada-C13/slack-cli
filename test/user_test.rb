require_relative "test_helper"
# Any tests involving a User should use the username 'SlackBot'

describe 'User class' do
  describe "self.list_all" do
    it 'should list all users' do
      VCR.use_cassette("users") do
        response = Recipient.get("https://slack.com/api/users.list")
        all_users = User.list_all
        expect(response.code).must_equal 200
        expect(all_users[0].name).must_equal "slackbot"
        expect(all_users[0].slack_id).must_equal "USLACKBOT"
        expect(all_users[0].real_name).must_equal "Slackbot"
      end
    end
  end

  describe "details" do
    it 'should get the details of a specified user' do
      VCR.use_cassette("users") do
        response = Recipient.get("https://slack.com/api/users.list")
        slackbot = User.new(slack_id: "USLACKBOT", name: "slackbot", real_name:"Slackbot")
        expect(response.code).must_equal 200
        expect(slackbot.details).must_include slackbot.name
        expect(slackbot.details).must_include slackbot.real_name
        expect(slackbot.details).must_include slackbot.slack_id
      end
    end
  end
end