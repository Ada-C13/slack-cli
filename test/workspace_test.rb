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
    it "takes a string and selects a channel" do
      @workspace.select_channel("random")
      expect(@workspace.selected).must_be_kind_of Channel
      expect(@workspace.selected.name).must_equal "random"

      @workspace.select_channel("CV6AN643F")
      expect(@workspace.selected).must_be_kind_of Channel
      expect(@workspace.selected.id).must_equal "CV6AN643F"
    end
    
    it "raises an error for bad parameters" do
      expect { @workspace.select_channel(1) }.must_raise ArgumentError
      expect { @workspace.select_channel([]) }.must_raise ArgumentError
    end

    it "raises an error if channel not found" do
      expect { @workspace.select_channel("No such channel") }.must_raise ArgumentError
      expect(@workspace.selected).must_be_nil
    end
  end # describe "select_channel"

  describe "select_user" do
    it "takes a string and returns a user" do
      @workspace.select_user("slackbot")
      expect(@workspace.selected).must_be_kind_of User
      expect(@workspace.selected.name).must_equal "slackbot"

      @workspace.select_user("USLACKBOT")
      expect(@workspace.selected).must_be_kind_of User
      expect(@workspace.selected.id).must_equal "USLACKBOT"
    end
    
    it "raises an error for bad parameters" do
      expect { @workspace.select_user(1) }.must_raise ArgumentError
      expect { @workspace.select_user([]) }.must_raise ArgumentError
    end

    it "raises an error if user not found" do
      expect { @workspace.select_user("No such user") }.must_raise ArgumentError
      expect(@workspace.selected).must_be_nil
    end
  end # describe "select_user"

  describe "show_details" do
    it "returns a string" do
      @workspace.select_user("USLACKBOT")
      details = @workspace.show_details
      expect(details).must_be_kind_of String

      @workspace.select_channel("CV6AN643F")
      details = @workspace.show_details
      expect(details).must_be_kind_of String
    end
    
    it "raises an error if nothing is selected" do
      expect { @workspace.show_details }.must_raise ArgumentError
    end
  end # describe "show_details"

  describe "send_message" do
    it "sends a message" do
      @workspace.select_user("USLACKBOT")
      VCR.use_cassette("send") do 
        result = @workspace.send_message("test")
        expect(result["message"]["text"]).must_equal "test"
      end
    end

    it "raises an Error if HTTP Result is not 200" do
      @workspace.select_user("USLACKBOT")
      VCR.use_cassette("send500") do 
        expect { @workspace.send_message("test") }.must_raise RuntimeError
      end
    end

    it "raises an Error if Slack says it's not ok" do
      @workspace.select_user("USLACKBOT")
      VCR.use_cassette("sendnotok") do 
        expect { @workspace.send_message("test") }.must_raise RuntimeError
      end
    end

    it "raises an error if message is not a string" do
      @workspace.select_user("USLACKBOT")
      expect { @workspace.send_message(1) }.must_raise ArgumentError
      expect { @workspace.send_message([]) }.must_raise ArgumentError
    end

    it "raises an error if nothing is selected" do
      expect { @workspace.send_message("test") }.must_raise ArgumentError
    end

  end # describe "send_message"

end # class Workspace