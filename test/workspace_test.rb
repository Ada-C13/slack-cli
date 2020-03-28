require_relative 'test_helper'
require_relative '../lib/workspace'

describe "Workspace" do
  before do
    @workspace = nil
    VCR.use_cassette("workspace_endpoint") do
      @workspace = Workspace.new
    end
  end
  describe "initialize" do
    it "creates a instance of Workspace" do
      # VCR.use_cassette("workspace_endpoint") do
      
      expect(@workspace).must_be_kind_of Workspace
    end
  end
  
  describe "select" do
    it "selects a channel" do
      @workspace.select_channel('random')
      expect(@workspace.selected).must_be_kind_of Channel
    end
  end
  
  it "selects a user" do
    VCR.use_cassette("workspace_endpoint") do
      # @workspace = Workspace.new
      @workspace.select_user('USLACKBOT')
      expect(@workspace.selected).must_be_kind_of User
    end
  end
  
  describe "send message" do
    it 'sends message to user' do
      VCR.use_cassette('workspace_endpoint') do
        #  @workspace = Workspace.new
        @workspace.select_user('USLACKBOT')
        @message = @workspace.send_message('Message')
      end
      expect(@message).must_equal true
    end
    
    it 'sends message to channel' do
      VCR.use_cassette('workspace_endpoint') do
        @workspace.select_channel('random')
        @message = @workspace.send_message('Message')
      end
      expect(@message).must_equal true
    end
    
    describe "show details" do
      it 'shows details of the user' do
        VCR.use_cassette('workspace_endpoint') do
          @workspace.select_user('USLACKBOT')
        end
        expect(@workspace.show_details).must_be_kind_of String
      end
    end
  end
end