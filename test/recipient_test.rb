require_relative "test_helper"

describe Recipient do
  describe "initialize" do
    it "initialize a instance of Recipient" do
      recipient = Recipient.new("NNNN", "Ken")
      expect(recipient).must_be_kind_of Recipient
    end
  end

  describe "self.list_all method" do
    it "raise NotImplementedError if user tries to call this class method" do
      expect{Recipient.list_all}.must_raise NotImplementedError
    end
  end
end