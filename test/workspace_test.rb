require_relative "test_helper"
require_relative "../lib/workspace"

describe Workspace do
  before do
    VCR.use_cassette('workspace') do
      @workspace = Workspace.new
    end
  end
  
  describe 'Constructor' do
    it 'can create a Workspace instance' do
      expect _(@workspace).must_be_instance_of Workspace
    end
    
    it 'has users, channels and selected' do
      expect _(@workspace.channels).must_be_instance_of Array
      expect _(@workspace.users).must_be_instance_of Array
      assert_nil(@workspace.selected)
    end
    
    it 'populates users and channels' do
      expect _(@workspace.channels.first).must_be_instance_of Channel
      expect _(@workspace.users.first).must_be_instance_of User
    end
  end
  describe 'select_channel' do
    before do    
      @user_name = "Fifi"
      @user_id = "DAT7CLL1Y"
      @users = @workspace.users
      
      @channel_name = "random"
      @channel_id = "CV5H594KE"
      @channels = @workspace.channels
    end
    
    it 'sets @selected to the found channel' do
      @workspace.select_channel name: @channel_name
      channel = @workspace.find_recipient(list_all: @channels, name: @channel_name)
      expect(@workspace.selected).must_equal channel
    end
    
    it 'sets selected to nil if no channel found' do
      @workspace.select_channel name: "NENA"
      assert_nil(@workspace.selected)
    end
  end
  
  describe 'select_user' do
    before do    
      @user_name = "Fifi"
      @user_id = "DAT7CLL1Y"
      @users = @workspace.users
    end
    
    it 'sets @selected to the found user' do
      @workspace.select_user name: @user_name
      user = @workspace.find_recipient(list_all: @users, name: @user_name)
      expect(@workspace.selected).must_equal user
    end
    
    it 'sets selected to nil if no user found' do
      @workspace.select_user name: "NENA"
      assert_nil(@workspace.selected)
    end
  end
  
  describe "find_recipient" do
    before do
      @user_name = "Fifi"
      @user_id = "DAT7CLL1Y"
      @users = @workspace.users
      
      @channel_name = "random"
      @channel_id = "CV5H594KE"
      @channels = @workspace.channels
    end
    
    it "returns the correct User by slack id or name" do
      user = @workspace.find_recipient(list_all: @users, name: @user_name) 
      expect _(@user_name).must_be_instance_of String
      expect _(@user_id).must_be_instance_of String
    end
    
    it "returns the correct Channel by slack id or name" do
      channel = @workspace.find_recipient(list_all: @channels, name: @channel_name)
      expect _(channel).must_be_instance_of Channel
      expect (channel.slack_id).must_equal @channel_id
      channel = @workspace.find_recipient(list_all: @channels, slack_id: @channel_id)
      expect _(channel).must_be_instance_of Channel
      expect (channel.name).must_equal @channel_name
    end
    
    it "raises ArgumentError if both name and slack id aren't provided" do
      expect {@workspace.find_recipient(list_all: [])}.must_raise ArgumentError
    end
    
    it "returns nil if no recipient found from name or slack id" do
      assert_nil (@workspace.find_recipient(list_all: @channels, name: "NENA"))
      assert_nil (@workspace.find_recipient(list_all: @users, slack_id: "NENA"))
    end
  end
end  