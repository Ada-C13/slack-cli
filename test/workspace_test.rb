require_relative 'test_helper'
require_relative '../lib/workspace'
require_relative '../lib/channel'
require_relative '../lib/user'


describe "initialize" do 

  it "will create a workspace object" do 

    VCR.use_cassette("channel_data") do
      workspace = Workspace.new
      workspace.must_be_instance_of Workspace
    end

    VCR.use_cassette("user_data") do
      workspace = Workspace.new
      workspace.must_be_instance_of Workspace
    end
  end 
end 


describe "class methods" do 

  it "will return users" do 
    VCR.use_cassette("user_data") do
      workspace = Workspace.new
      workspace.list_users.must_be_instance_of Array
    end
  end 

  it "will return channels" do 

    VCR.use_cassette("channel_data") do
      workspace = Workspace.new
      workspace.list_channels.must_be_instance_of Array
    end
  end
  
  it "will select a user" do 

    VCR.use_cassette("user_data") do
      workspace = Workspace.new
      slack_bot_id = workspace.select_user("USLACKBOT")
      slack_bot_id.must_be_instance_of UserRecipient 
    end

  end 


  it "will select a channel" do 
    VCR.use_cassette("channel_data") do
      workspace = Workspace.new
      slack_channel = workspace.select_channel("CUVKG668J")
      slack_channel.must_be_instance_of ChannelRecipient 
    end
  end 

  it "will get the details of the object" do 
    VCR.use_cassette("channel_data") do
      workspace = Workspace.new
      workspace.select_channel("CUVKG668J")
      details = workspace.get_details
      details.must_be_instance_of String 
    end

  end 

  it "return a string that tells user id is invalid" do 
    VCR.use_cassette("user_data") do
      workspace = Workspace.new
      workspace.select_channel("YEET")
      details = workspace.get_details
      details.must_equal "You have not chosen a user or channel, can't grab details for ya"
 
    end

  end 

  it "can send a valid message" do
    VCR.use_cassette("user_data") do
      workspace = Workspace.new
      quin = workspace.select_user("UUVTJ2NPK")
      response = quin.send_message("Hey I can post messages from test!")
      expect(response["ok"]).must_equal true
    end
  end
end 
