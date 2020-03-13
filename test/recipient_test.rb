require "test_helper"

describe "Recipient Class" do
  before do
    @recipient = Recipient.new(name: "ElfGang", slack_id: "qwerty123")
  end

  describe "Instantiation" do
    it "creates an instance of Recipient" do
      expect(@recipient).must_be_kind_of Recipient
    end

    it "has a name" do
      expect(@recipient.name).must_equal "ElfGang"
    end

    it "has a Slack ID" do
      expect(@recipient.slack_id).must_equal "qwerty123"
    end
  end

  describe "self.get_api_data" do
    it "receives data from Slack API" do
      response = nil
      VCR.use_cassette("list_users_endpoint") do
        response = Recipient.get_api_data(url: "https://slack.com/api/users.list")
      end

      expect(response).must_be_kind_of HTTParty::Response
      expect(response.code).must_equal 200
      expect(response["ok"]).must_equal true

      response_2 = nil
      VCR.use_cassette("list_conversations_endpoint") do
        response_2 = Recipient.get_api_data(url: "https://slack.com/api/conversations.list")
      end

      expect(response_2).must_be_kind_of HTTParty::Response
      expect(response.code).must_equal 200
      expect(response["ok"]).must_equal true
    end

    it "raises an error when response has 'ok' set to false" do
      # invalid url path
      # wron cassete?
      VCR.use_cassette("list_users_endpoint") do
        expect {Recipient.get_api_data(url: "https://slack.com/api/use.call")}.must_raise SlackAPIError
      end

      # invalid token?
    end

    # it "raises an error when response status is not 200" do
    # end
  end

  describe "self.load_all" do
    it "raises NotImplementedError" do
      expect{Recipient.load_all}.must_raise NotImplementedError
    end
  end

  describe "get_details" do
    it "raises NotImplementedError" do
      expect{@recipient.get_details}.must_raise NotImplementedError
    end
  end
end