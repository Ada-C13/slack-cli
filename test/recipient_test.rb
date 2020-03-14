require_relative "test_helper"

describe "Recipient class" do 
  before do
    @recipient = Slack::Recipient.new(slack_id: "123456", name: "hannah-j-test")
  end 

  describe "#initialize" do
    it "responds to slack_id and name" do 
      expect(@recipient).must_respond_to :slack_id 
      expect(@recipient).must_respond_to :name
    end 
  end 


  describe "#send_message" do 
    it "sends a message" do 
      VCR.use_cassette("Recipient#send_message") do 

        recipient = Slack::Recipient.new(slack_id: "7891011", name: "general")

        expect(@recipient.send_message("Howdy")).must_equal true 

        expect(recipient.send_message("Good morning!")).must_equal true 
      end  
    end 

    it "raises SlackApiError" do
      VCR.use_cassette("Recipient#send_message") do
        recipient = Slack::Recipient.new(slack_id: "123456", name: "test-channel")

        expect{recipient.send_message("Hungry")}.must_raise SlackApiError
      end 
    end 
  end 

  describe "#details" do 
    it "raises NotImplementedError" do 
      expect{@recipient.details}.must_raise NotImplementedError
    end 
  end 

  describe "self.list_all" do 
    it "raises NotImplementedError" do 
      expect{Slack::Recipient.list_all}.must_raise NotImplementedError
    end 
  end 
end 