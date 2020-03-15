require_relative 'test_helper'

describe "workspace class" do
  before do
    VCR.use_cassette("workspace") do
      @workspace = Slack::Workspace.new
    end
  end

  describe "initialize" do

    it "will load a list of all users in the server" do
      VCR.use_cassette("workspace") do
        expect(@workspace.users).must_be_kind_of Array
        expect(@workspace.users.length).must_equal 10
      end
    end

    it "will load a list of all channels in the server" do
      VCR.use_cassette("workspace") do
        expect(@workspace.channels).must_be_kind_of Array
        expect(@workspace.channels.length).must_equal 3
      end
    end

  end

  describe "workspace class methods" do
    it "will allow the user to select a channel" do
      VCR.use_cassette("workspace") do
        expect(@workspace.select_channel("general")).must_be_kind_of Slack::Channel
      end
    end

    it "will allow the user to select a user" do
      VCR.use_cassette("workspace") do
        expect(@workspace.select_user("vera")).must_be_kind_of Slack::User
      end
    end

    it "will raise an argument error if an invalid channel is selected" do
      VCR.use_cassette("workspace") do
        expect{@workspace.select_user("fake")}.must_raise ArgumentError
      end
    end

    it "will raise an argument error if an invalid user is selected" do
      VCR.use_cassette("workspace") do
        expect{@workspace.select_channel("fake")}.must_raise ArgumentError
      end
    end
  end

end