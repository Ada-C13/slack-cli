require_relative "test_helper"
require_relative "../lib/conversation"

describe "conversation" do
  before do
    fake_convo = {
      "id" => "fake_convo"
    }
    @conversation = Slack::Conversation.new(fake_convo)
    
  end

  describe "initialize" do
    it "creates a Conversation object" do
      expect(@conversation).must_be_kind_of Slack::Conversation
    end

    it "sets the conversation id" do
      expect(@conversation.id).must_equal "fake_convo"
    end
  end

  describe "post_message" do
    # ok must equal true
    # raises InvalidRecipientError, no valid conversation with specified ID
  end

  describe "details" do
    # raises NotImplementedError
  end

  describe "self.get_all" do
    it "gets all conversations" do
      
    end
  end

end