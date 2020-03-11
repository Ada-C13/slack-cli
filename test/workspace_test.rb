require_relative 'test_helper'

describe "workspace" do
  describe "initialize" do
    it "instantiates a Workspace class instance" do
      test_space = Workspace.new
      expect(test_space).must_be_instance_of Workspace
      expect(test_space.users).must_be_instance_of Array
      expect(test_space.channels).must_be_instance_of Array
    end
  end

  describe "select_user" do
    before do
      @test_space = Workspace.new
    end

    it "returns the instance variable @selected" do
      expect(@test_space.select_user(username: "slackbot")).must_equal @test_space.selected
      expect(@test_space.select_user(id: "bogus")).must_be_nil
    end

    it "raises an ArgumentError if neither the Slack ID or name is passed in" do
      expect{@test_space.select_user()}.must_raise ArgumentError
    end
  end

  describe "select_channel" do
    before do
      @test_space = Workspace.new
    end

    it "returns the instance variable @selected" do
      expect(@test_space.select_channel(name: "random")).must_equal @test_space.selected
      expect(@test_space.select_channel(id: "bogus")).must_be_nil
    end

    it "raises an ArgumentError if neither the Slack ID or name is passed in" do
      expect{@test_space.select_channel()}.must_raise ArgumentError
    end
  end
end