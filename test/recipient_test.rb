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