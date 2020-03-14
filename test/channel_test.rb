require_relative "test_helper"

describe "Channel class" do 
  # describe "#initialize" do 
  # end 

  describe "self.get" do 
    it "returns a response of channels list from API" do 
      VCR.use_cassette("channels-list-endpoint") do 
        url = "https://slack.com/api/channels.list"

        response = Slack::Channel.get(url)

        expect(response["ok"]).must_equal true
      end 
    end
  end 


  describe "#send_message(text, selected)" do 
    it "sends a message to a selected channel" do 
      VCR.use_cassette("channels-list-endpoint") do 

        workspace = Slack::Workspace.new

        channel = workspace.select_channel("hannah-j-test")       

        expect(channel.send_message("Good morning!", channel)).must_equal true 
      end  
    end 

    it "raises SlackApiError" do
      VCR.use_cassette("channels-list-endpoint") do
        channel = Slack::Channel.new(slack_id: "123456", name: "test-channel")

        expect{channel.send_message("Hungry", channel)}.must_raise SlackApiError
      end 
    end 
  end 


  describe "#details" do
    it "returns the channel details" do 
      VCR.use_cassette("channels-list-endpoint") do 
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
      VCR.use_cassette("channels-list-endpoint") do 
        channel_list = Slack::Channel.list_all

        expect(channel_list).must_be_kind_of Array

        channel_list.each do |channel|
          expect(channel).must_be_kind_of Slack::Channel 
        end 
      end 
    end 
  end 
end 