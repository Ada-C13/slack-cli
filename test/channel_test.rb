require_relative "test_helper"

describe "Channel class" do 
  describe "#initialize" do 
    it "responds to topic and member_count" do 
      VCR.use_cassette("conversations-list-endpoint") do 

        profile = {
          :slack_id => "1234567",
          :name => "random" 
        }


        expect(Slack::Channel.new(profile)).must_respond_to :topic   
        expect(Slack::Channel.new(profile)).must_respond_to :member_count
      end 
    end 
  end 

  describe "self.get" do 
    it "returns a response of channels list from API" do 
      VCR.use_cassette("conversations-list-endpoint") do 
        url = "https://slack.com/api/conversations.list"
        token = {
          token: ENV["SLACK_TOKEN"] 
        }

        response = Slack::Channel.get(url, token)

        expect(response["ok"]).must_equal true
      end 
    end
  end 
  

  describe "#details" do
    it "returns the channel details" do 
      VCR.use_cassette("conversations-list-endpoint") do 
        slack_id = "CV60LA20G"
        name = "general"
        topic = "Hot pot"
        member_count = 5

        channel = Slack::Channel.new(slack_id: slack_id, name: name, topic: topic, member_count: member_count)

        expect(channel.details).must_be_kind_of Hash      
        expect(channel.details.length).must_equal 4   
        expect(channel.details.values[0]).must_equal slack_id    
        expect(channel.details.values[1]).must_equal name  
        expect(channel.details.values[2]).must_equal topic  
        expect(channel.details.values[3]).must_equal member_count    
        
        (0..2).each do |i|
          expect(channel.details.values[i]).must_be_kind_of String
        end 

        expect(channel.details.values[3]).must_be_kind_of Integer
      end 
    end 
  end 


  describe "self.list_all" do 
    it "creates and returns instances of channels" do 
      VCR.use_cassette("conversations-list-endpoint") do 
        channel_list = Slack::Channel.list_all

        expect(channel_list).must_be_kind_of Array

        channel_list.each do |channel|
          expect(channel).must_be_kind_of Slack::Channel 
        end 
      end 
    end 
  end 


  describe "#load_message_history" do 
    it "loads message history for a selected channel" do 
      VCR.use_cassette("conversations-history-endpoint") do 
        workspace = Slack::Workspace.new
        channel =  workspace.select_channel("hannah-j-test")
        history = channel.load_message_history 
        expect(history).must_be_kind_of Array
      end 
    end 

    it "raises SlackApiError when given a bogus channel" do 
      VCR.use_cassette("conversations-history-endpoint") do 
        channel = Slack::Channel.new(slack_id: "123456", name: "goblin test")

        expect{channel.load_message_history}.must_raise SlackApiError
      end 
    end 
  end 

  describe "#message_history" do 
    it "shows message history for a selected channel" do 
      VCR.use_cassette("conversations-history-endpoint") do 

        channel = Slack::Workspace.new.select_channel("hannah-j-test")

        msg_history = channel.message_history
        
        expect(msg_history).must_be_kind_of Array
      end 
    end 
  end 

end 