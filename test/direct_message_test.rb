require_relative "test_helper"
require_relative "../lib/direct_message"

describe "direct message" do
  before do
    dm = {
      "id" => "DUYS4LFM0",
      "created" => 1584065406,
      "is_archived" => false,
      "is_im" => true,
      "is_org_shared" => false,
      "user" => "USLACKBOT",
      "is_user_deleted" => false,
      "priority" => 0,
    }
    @direct_message = Slack::DirectMessage.new(dm)

  end

  describe "initialize" do

    it "creates a direct message object" do
      expect(@direct_message).must_be_kind_of Slack::DirectMessage
    end

    it "stores the direct message's ID" do
      expect(@direct_message.id).must_equal "DUYS4LFM0"
    end

    it "stores the direct message's receiving user" do
      expect(@direct_message.user).must_equal "USLACKBOT"
    end

  end

  describe "list_all" do
    it "returns an array of DirectMessage objects" do
      VCR.use_cassette("conversations_list_direct_messages_endpoint") do
        results = Slack::DirectMessage.list_all
        expect(results).must_be_kind_of Array
        expect(results.all? { |result| result.class == Slack::DirectMessage } ).must_equal true  
      end
    end
    
  end

  describe "get_all" do
    
    it "returns an array of Channel objects" do
      VCR.use_cassette("conversations_list_direct_messages_endpoint") do
        results = Slack::DirectMessage.list_all
        expect(results).must_be_kind_of Array
        expect(results.all? { |result| result.class == Slack::DirectMessage } ).must_equal true  
      end
    end
    
    # one of the Direct Messages must be with Slackbot 
    it "has a DirectMessage with the user USLACKBOT" do
      VCR.use_cassette("conversations_list_direct_messages_endpoint") do
        direct_messages = Slack::DirectMessage.list_all
        expect(direct_messages.any? { |direct_message| direct_message.user == "USLACKBOT" } ).must_equal true  
      end
    end
    
  end
  

end