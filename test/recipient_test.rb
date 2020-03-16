require_relative 'test_helper'

describe SlackCli::Recipient do
  describe "Recipient" do
    describe 'Recipient Instantiation' do
      it 'creates an instance of a recipient' do
        test_recipient = SlackCli::Recipient.new("1", "testname")
        #expects a recipient to be a recipiene object
        expect(test_recipient).must_be_kind_of SlackCli::Recipient
        expect(test_recipient.name).must_equal "testname"
      end

      it "validates Recipient paramters" do
        expect{SlackCli::Recipient.new("1", 2)}.must_raise ArgumentError
      end
    end #initialize
  end #class
end #module