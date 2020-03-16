require_relative 'test_helper'

# url = ENV['BASE_URL'] + ENV['SUB_USER_URL'] + "token=" + ENV['SLACK_TOKEN']
# url = ENV['BASE_URL'] + ENV['SUB_CHANNEL_URL'] + "token=" + ENV['SLACK_TOKEN']

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