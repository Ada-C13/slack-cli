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


  end 
end 