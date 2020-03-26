require_relative "test_helper"
require_relative '../lib/workspace'

describe "Workspace" do
  describe "Initialize" do
    before do
      VCR.use_cassette("create_workspace") do
        @workspace = Workspace.new
      end
    end

    it "will create a new Workplace" do
      expect(@workspace).must_be_instance_of Workspace
    end

    it "will have an array of Channels and Users" do
      expect(@workspace.channels).must_be_instance_of Array
      expect(@workspace.users).must_be_instance_of Array
    end
  end

  describe "select_channel(channel_name)" do
    before do 
      VCR.use_cassette("create_workspace")do
      @workspace = Workspace.new
    end
    end
  
    it "will return an instance of Channel based on the user input" do
      @workspace.select_channel("random")
      expect(@workspace.selected).must_be_instance_of Channel
      expect(@workspace.selected.name).must_equal "random"
    end
    
    it "will return nil if a channel provided isn't valid" do
      @workspace.select_channel("nothing found here")
      expect(@workspace.selected).must_be_nil
    end

  end

  describe "select_channel(channel_name)" do
    before do 
      VCR.use_cassette("create_workspace")do
      @workspace = Workspace.new
    end
    end
  
    it "will return a Channel based on the user input - using channel name" do
      @workspace.select_channel("random")
      expect(@workspace.selected).must_be_instance_of Channel
      expect(@workspace.selected.name).must_equal "random"
    end

     
    it "will return a Channel based on the user input - using channel name" do
      @workspace.select_channel("CRQ896WKD")
      expect(@workspace.selected).must_be_instance_of Channel
      expect(@workspace.selected.name).must_equal "general"
    end
  end

  describe "select_user(user_name)" do
    before do 
      VCR.use_cassette("create_workspace")do
      @workspace = Workspace.new
    end
    end
  
    it "will return an instance of User based on the user input" do
      @workspace.select_user("Sharon Cheung")
      expect(@workspace.selected).must_be_instance_of User
      expect(@workspace.selected.real_name).must_equal "Sharon Cheung"
    end

    it "will return an instance of User based on the user input" do
      @workspace.select_user("US1N1DHGQ")
      expect(@workspace.selected).must_be_instance_of User
      expect(@workspace.selected.real_name).must_equal "Joseph"
    end

    it "will return nil if an user provided isn't valid" do
      @workspace.select_user("nothing found here")
      expect(@workspace.selected).must_be_nil
    end

  end

  describe "show_details" do
    before do 
      VCR.use_cassette("create_workspace")do
      @workspace = Workspace.new
      end
    end

  
    it " will return a user details" do
      @workspace.select_user("Joseph")
      user_details = @workspace.show_details

      expect(user_details).must_be_kind_of TablePrint::Returnable
      
    end

    it "will return a channel details" do
      @workspace.select_channel('general')
      channel_details = @workspace.show_details

      expect(channel_details).must_be_kind_of TablePrint::Returnable
     
    end
  end

  describe "send_message(message)" do
    before do
      VCR.use_cassette("create_workspace")do
      @workspace = Workspace.new
      end
    end

    it "will return true when the message go thru when a valid user/channel input" do
      message_sent = 
      VCR.use_cassette("create_workspace") do
        @workspace.select_user('Joseph')
        message_sent = @workspace.send_message("Hello")
      end

      expect(message_sent).must_be_kind_of TrueClass
    end
  end

  #Optional - updating user setting
  xdescribe "set_profile_setting(name, emoji)" do
    # tried to write the test for it but couldn't quite figure out yet..
    #can only use it for the authorized user
    it "will return ture it is an User that can change the setting" do
      VCR.use_cassette("create_workspace")do
      @workspace = Workspace.new
      end

      @workspace.select_user('keikei1128')
      response = @workspace.set_profile_setting("Sharon", ":unicorn_face:")
      
      expect(response.selected.status_emoji).must_equal ":unicorn_face:"
    end
  end
end  

