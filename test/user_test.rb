require_relative 'test_helper'
require_relative '../lib/slack'

describe "user" do
  before do
    VCR.use_cassette("list-endpoint") do
      @workspace = Workspace.new

      @user = @workspace.users.find {|u| u.username == "slackbot" }
    end
  end

  describe "initialize method" do
    it "will be an instance of the User class" do
      expect(@user).must_be_instance_of User
    end

    it "will have the correct attributes" do
      expect(@user).must_respond_to :slack_id
      expect(@user.slack_id).must_equal "USLACKBOT"

      expect(@user).must_respond_to :username
      expect(@user.username).must_equal "slackbot"

      expect(@user).must_respond_to :real_name
      expect(@user.real_name).must_be_instance_of String
      expect(@user.real_name).must_equal "Slackbot"

      expect(@user).must_respond_to :status_text
      expect(@user.status_text).must_equal ""

      expect(@user).must_respond_to :status_emoji
      expect(@user.status_emoji).must_equal ""
    end
  end
  
  describe "get method" do
    before do
      VCR.use_cassette("list-endpoint") do
        url = "https://slack.com/api/users.list"

        @my_response = User.get(url)
      end
    end

    it "makes an API call" do
      expect(@my_response).must_be_instance_of HTTParty::Response
      expect(@my_response["ok"]).must_equal true
      expect(@my_response["members"].first["id"]).must_equal "USLACKBOT"
    end

    it "will throw an error if invalid url is given" do
      VCR.use_cassette("error-cases") do
        expect{User.get("https://slack.com/api/lololthisisntreal")}.must_raise ArgumentError
      end
    end
  end

  describe "send message method" do
    before do
      VCR.use_cassette("post-message-endpoint") do
        my_message = "Test message!"
        @random_channel.send_message(my_message)

      end
    end

  end

  describe "details method" do
    it "returns a formatted list of its own deets" do
      expect(@user.details).must_be_instance_of TablePrint::Returnable
    end
  end

  describe "list all method" do
    before do
      VCR.use_cassette("list-endpoint") do
        @my_users = User.list_all
      end
    end

    it "can be called" do
      expect(@my_users).must_be_instance_of Array
      expect(@my_users.first).must_be_instance_of User
    end

    it "returns a full list of all users" do
      expect(@my_users.length).must_equal 14
      expect(@my_users[0].username).must_equal "slackbot"
      expect(@my_users.last).must_be_instance_of User
    end
  end
end