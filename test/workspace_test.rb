require "test_helper"

describe "Workspace Class" do
  before do
    VCR.use_cassette("workspace_new") do
      @workspace = Workspace.new
    end
  end

  describe "Instantiation" do
    it "creates an instanse of Workspace" do
      expect(@workspace).must_be_kind_of Workspace
    end
  end
    
  describe "users" do
    it "is an Array" do
      expect(@workspace.users).must_be_kind_of Array
    end

    it "has Users" do
      expect(@workspace.users[0]).must_be_kind_of User
    end

    it "one of the users is Slackbot" do
      count = 0
      @workspace.users.each do |user|
        count += 1 if user.slack_id == "USLACKBOT"
      end
      expect(count).must_equal 1
    end
  end

  describe "channels" do
    it "is an Array" do
      expect(@workspace.channels).must_be_kind_of Array
    end

    it "has Channels" do
      expect(@workspace.channels[0]).must_be_kind_of Channel
    end

    it "one of the channels is #random" do
      count = 0
      @workspace.channels.each do |channel|
        count += 1 if channel.name == "random"
      end
      expect(count).must_equal 1
    end
  end

  describe "list_users" do
    it "return a string" do
      expect(@workspace.list_users).must_be_kind_of String
    end
    # it "this string is a concat of strings - one per user" do
      
    # end
  end

  describe "list_channels" do
    it "returns a string" do
      expect(@workspace.list_channels).must_be_kind_of String
    end
    # it "this string is a concat of strings - one per channel" do
      
    # end
  end
end