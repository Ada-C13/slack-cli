require_relative 'test_helper.rb'

describe "User" do
  it "can initialize user" do
    slack_id = "UUT7ESHPU"
    real_name = "katie.vandervoort"
    status_text = "srry busy"
    status_emoji = ":smiley:"
    name = "Katie Vandervoort"
    new_user = User.new(slack_id: slack_id, real_name: real_name, status_text: status_text, status_emoji: status_emoji, name: name)
    expect(new_user).must_be_kind_of User
    expect(new_user.slack_id).must_equal slack_id
    expect(new_user.real_name).must_equal real_name
    expect(new_user.status_text).must_equal status_text
    expect(new_user.status_emoji).must_equal status_emoji
    expect(new_user.name).must_equal name

  end

  describe "self.get" do
    it "User.get api call works" do
      response = nil

      VCR.use_cassette("User.get") do
        params = {
          token: ENV['SLACK_TOKEN'],
        }
        response = User.get("https://slack.com/api/users.list",params)
      end

      expect(response).must_be_kind_of HTTParty::Response
      expect(response["ok"]).must_equal true
    end

    it "bad URL returns correct error" do
      response = nil

      VCR.use_cassette("user_bad_api_call") do
        params = {
          token: ENV['SLACK_TOKEN'],
        }
        expect{User.get("https://slack.com/api/bad.endpoint",params)}.must_raise ArgumentError
      end
    end
  end

  it "can list all users" do
    VCR.use_cassette("self.list_all") do

      response = User.list_all

      expect(response).must_be_kind_of Array
      expect(response[0]).must_be_kind_of User
      expect(response[0].name).must_be_kind_of String
      expect(response[0].real_name).must_be_kind_of String
      expect(response[0].slack_id).must_be_kind_of String

      slack_bot = response.find{ |user| user.name == "slackbot"}
      expect(slack_bot.name).must_equal "slackbot"
      expect(slack_bot.real_name).must_equal "Slackbot"
    end

  end


end