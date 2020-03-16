require_relative 'test_helper'

describe 'Workspace' do 
  describe 'constructor' do
    before do
      VCR.use_cassette("workspace") do
        @workspace = Workspace.new
      end
    end
    it 'creates instance of Workspace' do
      expect(@workspace).must_be_kind_of Workspace
    end
    it 'has state @users and @channels' do
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.channels).must_be_kind_of Array
    end
    it "users contains users" do
      expect(@workspace.users.first).must_be_kind_of User
      target_user = @workspace.users.find {|user| user.name == "slackbot"}
      expect(target_user).must_be_kind_of User
    end

    it "channels contains channels" do
      expect(@workspace.channels.first).must_be_kind_of Channel
      target_channel = @workspace.channels.find {|channel| channel.name == "random"}
      expect(target_channel).must_be_kind_of Channel
    end
  end

  describe "print_list" do
    before do
      VCR.use_cassette("workspace") do
        @workspace = Workspace.new
      end
    end
    it "throws ArgError when given invalid recipient" do
      expect{@workspace.print_list("blue")}.must_raise ArgumentError
    end

  end

  describe "select" do
    before do
      VCR.use_cassette("workspace") do
        @workspace = Workspace.new
      end
    end
    it "throws ArgError when given invalid recipient" do
      expect{@workspace.select("oogie")}.must_raise ArgumentError
    end
    it "returns array of users" do
      target_a = @workspace.select("user")
      expect(target_a).must_be_kind_of Array
      expect(target_a.first).must_be_kind_of User
    end
    it "returns array of channels" do
      target_a = @workspace.select("channel")
      expect(target_a).must_be_kind_of Array
      expect(target_a.first).must_be_kind_of Channel
    end
  end
end