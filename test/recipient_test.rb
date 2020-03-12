require_relative "test_helper"

describe "recipient" do
  USERS_URI = "https://slack.com/api/users.list"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]

  describe "self.get" do
    it "receives response from the API call" do
      VCR.use_cassette("users_list_endpoint") do
        response = SlackCLI::Recipient.get(USERS_URI, {token: SLACK_TOKEN})
        expect(response["members"]).wont_be_nil
        expect(response["members"][0]["name"]).must_equal "slackbot"
        expect(response["members"][0]["id"]).must_equal "USLACKBOT"
      end
    end

    it "will raise an exception if the search fails" do
      VCR.use_cassette("users_list_endpoint") do
        # new_key = "bogus"
        # bad_url = ""
        expect{SlackCLI::Recipient.get(USERS_URI, {key: SLACK_TOKEN})}.must_raise SlackCLI::SlackAPIError
        # expect{Recipient.get(bad_url, {token: SLACK_TOKEN})}.must_raise SlackAPIError
      end
    end
  end

  describe "initialize" do
    it "instantiates a new Recipient class object" do
      id = "TESTID001"
      name = "test_recipient"
      new_recipient = SlackCLI::Recipient.new(id, name)
      expect(new_recipient).must_be_instance_of SlackCLI::Recipient
      expect(new_recipient.slack_id).must_equal id
      expect(new_recipient.name).must_equal name
    end
  end

  describe "#send_message" do
    it "can send a valid message" do
      VCR.use_cassette("chat_post_endpoint") do
        recipient01 = SlackCLI::Recipient.new("UV6BANLCV")
        response = recipient01.send_message("Can I do this?")
        expect(response).must_equal true
      end
    end
  
    it "will raise an exception when the recipient name or id is invalid" do
      VCR.use_cassette("chat_post_endpoint") do
        recipient01 = SlackCLI::Recipient.new("bogus")
        expect {recipient01.send_message("Let's get an error.")}.must_raise SlackCLI::SlackAPIError
      end
    end

    it "will raise an exception when missing the correct arguments" do
      VCR.use_cassette("chat_post_endpoint") do
        recipient02 = SlackCLI::Recipient.new("UV6BANLCV")
        expect {recipient02.send_message()}.must_raise ArgumentError
      end
    end
  
  end

  describe "#get_details" do
    it "is an abstract method that needs to be implemented by subclasses" do
      new_recipient = SlackCLI::Recipient.new("TESTID001", "test_recipient")
      expect{new_recipient.get_details}.must_raise NotImplementedError
    end
  end

  describe "self.list_all" do
    it "is an abstract method that needs to be implemented by subclasses" do
      expect{SlackCLI::Recipient.list_all}.must_raise NotImplementedError
    end
  end
end
