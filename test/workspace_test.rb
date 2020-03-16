require_relative 'test_helper'
require_relative '../lib/workspace'

describe "workspace" do
  before do
    VCR.use_cassette("list-endpoint") do
      @workspace = Workspace.new
    end
  end

  describe "initialize" do
    it "can be initialized" do
      expect(@workspace).must_be_instance_of Workspace
    end
    
    it "will have the appropriate attributes" do
      expect(@workspace).must_respond_to :users
      expect(@workspace.users).must_be_instance_of Array

      expect(@workspace).must_respond_to :channels
      expect(@workspace.channels).must_be_instance_of Array

      expect(@workspace).must_respond_to :selected
      expect(@workspace.selected).must_be_nil
    end
  end

  describe "select channel" do
    #TODO
  end

  describe "select user" do
    #TODO
  end

  describe "show details" do
    #TODO
  end
end