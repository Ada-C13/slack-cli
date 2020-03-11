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

  describe "get_details" do
    it "raises NotImplementedError" do
      expect{@recipient.get_details}.must_raise NotImplementedError
    end
  end
end