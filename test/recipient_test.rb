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
    it "sends a message to a selected user" do 
      VCR.use_cassette("users-list-endpoint") do 

        workspace = Slack::Workspace.new

        recipient = workspace.select_user("USLACKBOT")       

        expect(recipient.send_message("Good morning SLACKBOT!", recipient)).must_equal true 
      end  
    end 


    it "raises SlackApiError when given a bogus user name" do
      VCR.use_cassette("users-list-endpoint") do
        user = Slack::Recipient.new(slack_id: "123456", name: "goblin")

        expect{user.send_message("Hungry", user)}.must_raise SlackApiError
      end 
    end 


    it "sends a message to a selected channel" do 
      VCR.use_cassette("conversations-list-endpoint") do 

        workspace = Slack::Workspace.new

        recipient = workspace.select_channel("hannah-j-test")       

        expect(recipient.send_message("Good morning!", recipient)).must_equal true 
      end  
    end 

    it "raises SlackApiError when given a bogus channel name" do
      VCR.use_cassette("conversations-list-endpoint") do
        recipient = Slack::Recipient.new(slack_id: "123456", name: "goblin-channel")

        expect{recipient.send_message("Hungry", recipient)}.must_raise SlackApiError
      end 
    end 
  end 


  describe "#details" do 
    it "raises NotImplementedError" do 
      expect{@recipient.details}.must_raise NotImplementedError
    end 
  end 


  # optional
  describe "#load_message_history" do
    it "raises NotImplementedError" do 
      recipient = Slack::Recipient.new(slack_id: "123456", name: "bogus")
      expect{recipient.load_message_history}.must_raise NotImplementedError
    end 
  end 


  # optional
  describe "#message_history" do 
    it "shows message history for a selected user" do 
      VCR.use_cassette("conversations-history-endpoint") do 

        user = Slack::Workspace.new.select_user("sea otter")

        msg_history = user.message_history
        
        expect(msg_history).must_be_kind_of Array
      end 
    end 

    it "shows message history for a selected channel" do 
      VCR.use_cassette("conversations-history-endpoint") do 

        channel = Slack::Workspace.new.select_channel("hannah-j-test")

        msg_history = channel.message_history
        
        expect(msg_history).must_be_kind_of Array
      end 
    end 
  end 

  
  describe "self.list_all" do 
    it "raises NotImplementedError" do 
      expect{Slack::Recipient.list_all}.must_raise NotImplementedError
    end 
  end 

end 

describe "ENV" do 
  it "raises NoSlackTokenError if there is no token in .env" do 

    token = ENV["BOGUS_TOKEN"]

    expect{validate_env(token)}.must_raise NoSlackTokenError
  end 
end 