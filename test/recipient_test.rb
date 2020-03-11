require_relative "test_helper"

describe Recipient do
  describe "self.list_all method" do
    it "raise NotImplementedError if user tries to call this class method" do
      expect{Recipient.list_all}.must_raise NotImplementedError
    end
  end
end