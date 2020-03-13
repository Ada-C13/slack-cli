require_relative 'test_helper'

describe "class Workspace" do

  before do
    VCR.use_cassette("list") do 
      @workspace = Workspace.new
    end
  end

  describe "constructor" do
    it "initializes @users" do 
      expect(@workspace.users).must_be_kind_of Array
      @workspace.users.each do |user|
        expect(user).must_be_kind_of User
      end
    end

    it "initializes @channels" do 
      expect(@workspace.channels).must_be_kind_of Array
      @workspace.channels.each do |channel|
        expect(channel).must_be_kind_of Channel
      end
    end

  end # describe "constructor"

  describe "select_channel" do


  end # describe "select_channel"

  describe "select_user" do

  end # describe "select_user"

  describe "show_details" do

  end # describe "show_details"

  describe "send_message" do

  end # describe "send_message"

end # class Workspace
