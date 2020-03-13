require_relative "test_helper"

describe "Recipient" do
  
  describe "Initialize" do

    before do
      @recipient = SlackCLI::Recipient.new("BUTHFRBNW")
    end

    it "can create an instance of Recipient" do
      VCR.use_cassette("recipient_class") do
        expect(@recipient).must_be_kind_of SlackCLI::Recipient
        #expect(@recipient).must_equal
      end
    end

    it "can pull information about channels.list via get_response" do
      VCR.use_cassette("recipient_class") do
        expect(SlackCLI::Recipient.get_response("channels.list")).must_be_kind_of HTTParty::Response
        expect(SlackCLI::Recipient.get_response("channels.list")["channels"].length).must_equal 5
      end
    end

    it "can pull information about users.list via get_response" do
      VCR.use_cassette("recipient_class") do
        expect(SlackCLI::Recipient.get_response("users.list")).must_be_kind_of HTTParty::Response
        expect(SlackCLI::Recipient.get_response("users.list")["members"].length).must_equal 8
      end
    end

    it "can send a message via send_message" do
      VCR.use_cassette("recipient_class") do
        #expect(SlackCLI::Recipient.get_response("users.list")).must_be_kind_of HTTParty::Response
        expect(SlackCLI::Recipient.send_message("i am a honeybucket.")).must_be_kind_of String  
      end
    end
  end
end