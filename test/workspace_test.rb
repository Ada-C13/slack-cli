require_relative "test_helper"

describe "Workspace class" do 

  describe "#initialize" do
    it "creates a `users` array and returns users' list" do 

      VCR.use_cassette("users-list-endpoint") do 
        users = Slack::Workspace.new.users

        expect(users).must_be_kind_of Array
        users.each do |user|
          expect(user).must_be_kind_of Slack::User
        end 
      end 
    end  

    it "creates a `channels` array and return channels' list" do 

      VCR.use_cassette("conversations-list-endpoint") do 
        channels = Slack::Workspace.new.channels

        expect(channels).must_be_kind_of Array
        channels.each do |channel|
          expect(channel).must_be_kind_of Slack::Channel
        end 
        
      end 
    end 
  end 


  describe "#list_users & #list_channels" do 
    before do 
      VCR.use_cassette("users-list-and-conversations-list-endpoint") do 
        @workspace = Slack::Workspace.new() 
      end 
    end 

    it "returns user list" do  
      expect(@workspace.list_users).must_be_instance_of TablePrint::Returnable
    end 

    it "returns channel list" do  
      expect(@workspace.list_channels).must_be_instance_of TablePrint::Returnable
    end 
  end 


  describe "#select_user(user_input)" do 
    before do 
      VCR.use_cassette("users-list-endpoint") do 
        @workspace = Slack::Workspace.new()
      end 
    end 

    it "selects a user as recipient if I supply a username" do 
      name = "sea otter" 
      user = @workspace.select_user(name)

      expect(user).must_be_kind_of Slack::User
      expect(user.name).must_equal name
    end 

    it "selects a user as recipient if I supply a slack_id" do 
      id = "USLACKBOT" 
      user = @workspace.select_user(id)

      expect(user).must_be_kind_of Slack::User
      expect(user.slack_id).must_equal id
    end 

    it "selects user as recipient if I supply a real_name" do 
      real_name = "Slackbot" 
      user = @workspace.select_user(real_name)

      expect(user).must_be_kind_of Slack::User
      expect(user.real_name).must_equal real_name
    end 
  end 


  describe "#select_channel(user_input)" do 
    before do 
      VCR.use_cassette("conversations-list-endpoint") do 
        @workspace = Slack::Workspace.new()
      end 
    end 

    it "selects a channel as recipient if I supply a channel name" do 
      name = "random"
      channel = @workspace.select_channel(name)

      expect(channel).must_be_kind_of Slack::Channel
      expect(channel.name).must_equal name
    end 

    it "selects a channel as recipient if I supply a slack_id" do 
      id = "CV86T0TPY"
      channel = @workspace.select_channel(id)

      expect(channel).must_be_kind_of Slack::Channel
      expect(channel.slack_id).must_equal id
    end 
  end 


  describe "#show_details" do 
    before do 
      VCR.use_cassette("users-list-and-conversations-list-endpoint") do 
        @workspace = Slack::Workspace.new()
      end 
    end 

    it "returns the selected user details" do 
      id = "USLACKBOT"

      # Invoke #select_user to assign "selected" variable
      @workspace.select_user(id)

      expect(@workspace.show_details).must_be_kind_of TablePrint::Returnable
    end 


    it "returns the selected channel details" do
      name = "hannah-j-test" 

      @workspace.select_channel(name)

      expect(@workspace.show_details).must_be_instance_of TablePrint::Returnable
    end 

    it "returns nil if no user or channel chosen" do 
      expect(@workspace.show_details).must_be_nil
    end 
  end 


  describe "#send_message" do 
    it "sends a message to a selected user" do  
      VCR.use_cassette("users-list-endpoint") do 
        workspace = Slack::Workspace.new()
        id = "USLACKBOT"
        workspace.select_user(id)

        expect(workspace.send_message("Hey!! I'm from test file!!")).must_equal true
      end  
    end 

    it "sends a message to a selected channel" do 
      VCR.use_cassette("conversations-list-endpoint") do 
        workspace = Slack::Workspace.new()
        name = "hannah-j-test"
        workspace.select_channel(name)

        expect(workspace.send_message("Hey!! I'm from test file")).must_equal true
      end    
    end 

    it "returns nil if there is no user or channel chosen" do 
      VCR.use_cassette("users-list-and-conversations-list-endpoint") do
        workspace = Slack::Workspace.new()
        expect(workspace.send_message("Good afternoon")).must_be_nil
      end 
    end 
  end 

  describe "#change_setting" do 
    it "changes profile settings" do 
      VCR.use_cassette("users-list-endpoint") do 
        workspace = Slack::Workspace.new()

        workspace.change_setting("sea otter", "🦦")

        expect(workspace.find_user_by_id("USLACKBOT").name).must_equal "sea otter"

        expect(workspace.find_user_by_id("USLACKBOT").status_emoji).must_equal "🦦"
      end 
    end 
  end 

  describe "#message_history" do 
    it "returns message history for a selected channel" do 
      VCR.use_cassette("conversations-history-endpoint") do
        workspace = Slack::Workspace.new()
        name = "hannah-j-test"
        workspace.select_channel(name)

        expect(workspace.message_history).must_be_instance_of Terminal::Table
      end 
    end 
  end 

  describe "#find_user_by_id" do 
    it "returns a user based on slack_id" do 
      VCR.use_cassette("users-list-endpoint") do
        
        workspace = Slack::Workspace.new() 
        bot = workspace.find_user_by_id("USLACKBOT")

        expect(bot).must_be_instance_of Slack::User
      end
    end
  end 
end 