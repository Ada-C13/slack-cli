require_relative 'test_helper'

describe SlackCli::Workspace do 
  describe "Workspace class" do 
    it "#select_channel will select random as channel" do 

      VCR.use_cassette("slack-posts") do

        slack_start = SlackCli::Workspace.new
        result = slack_start.select_channel("random")
        
        expect(result).must_be_instance_of SlackCli::Channel
        expect(slack_start.selected.name).must_equal "random"
        expect(slack_start.selected.slack_id).must_equal "CUTE2BDA6"
      end 
    end 
    
    it "#select_user will select slackbot as user" do 
      VCR.use_cassette("slack-posts") do
        slack_start = SlackCli::Workspace.new
        result = slack_start.select_user("slackbot")

        expect(result).must_be_instance_of SlackCli::User
        expect(slack_start.selected.name).must_equal "slackbot"
        expect(slack_start.selected.slack_id).must_equal "USLACKBOT"
      end 
    end
    
    it "#show_details will show correct info" do 
      VCR.use_cassette("slack-posts") do
        slack_start = SlackCli::Workspace.new
        select_one = slack_start.select_user("vwhwang38")
        result = select_one.show_details

        expect(result).must_be_instance_of String
        expect(result.match? /vwhwang38/).must_equal true 
      end 
    end 


    it "#show_details will show correct info from workspace as well" do 
      VCR.use_cassette("slack-posts") do
        slack_start = SlackCli::Workspace.new
        slack_start.select_channel("random")
        expect(slack_start.show_details).must_be_instance_of String
        expect(slack_start.show_details.match? /random/).must_equal true 
      end 
    end 

    it "can send show history of selected channel" do 
      VCR.use_cassette("channel_history") do 
        slack_start = SlackCli::Workspace.new
        channel = slack_start.select_channel("cats")
        response = channel.show_history 
        expect(response).must_be_instance_of Array
      end 
    end 
    




  end 
end 