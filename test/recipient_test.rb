require_relative "test_helper"

describe Recipient do
  describe "initialize" do
    it "initialize a instance of Recipient" do
      recipient = Recipient.new("NNNN", "Ken")
      expect(recipient).must_be_kind_of Recipient
    end
  end

  describe "self.list_all method" do
    it "raises NotImplementedError if user tries to call self.list_all" do
      expect{Recipient.list_all}.must_raise NotImplementedError
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("list_of_users") do
        expect{User.get("https://slack.com/api/whateverxxxxxxxxx")}.must_raise SlackAPIError
      end
    end
  end

  describe "details method" do
    it "raises NotImplementedError if user tries to call #details method" do
      recipient = Recipient.new("NNNN", "Ken")
      expect{recipient.details}.must_raise NotImplementedError
    end
  end
end