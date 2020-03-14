require_relative "test_helper"

describe "Workspace class" do 

  # Question: I cannot use `before block` here?
  # Because when I try to access @work_space inside of `VCR.use_cassette`, it gives me an error
  # before do 
  #   @workspace = Slack::Workspace.new()
  # end 


  describe "#initialize" do
    it "creates a `users` and `channels` array and return all their list" do 

      VCR.use_cassette("users-list-and-channels-list-endpoint") do 
        users = Slack::Workspace.new().users
        channels = Slack::Workspace.new().channels

        expect(users).must_be_kind_of Array
        expect(channels).must_be_kind_of Array

        expect(users[0]).must_be_kind_of Slack::User 
        expect(channels[0]).must_be_kind_of Slack::Channel
      end 

    end  
  end 


  describe "#select_user(user_input)" do 
    before do 
      VCR.use_cassette("users-list-endpoint") do 
        @workspace = Slack::Workspace.new()
      end 
    end 

    it "returns a user as recipient if I supply a username" do 
      name = "slackbot" 
      user = @workspace.select_user(name)

      expect(user).must_be_kind_of Slack::User
      expect(user.name).must_equal name
    end 

    it "returns a user as recipient if I supply a slack_id" do 
      id = "USLACKBOT" 
      user = @workspace.select_user(id)

      expect(user).must_be_kind_of Slack::User
      expect(user.slack_id).must_equal id
    end 

    it "returns a user as recipient if I supply a real_name" do 
      real_name = "Slackbot" 
      user = @workspace.select_user(real_name)

      expect(user).must_be_kind_of Slack::User
      expect(user.real_name).must_equal real_name
    end 

    # it "raises an ArgumentError if no user found" do 
    #   name = "elephant"
    #   expect{@workspace.select_user(name)}.must_raise ArgumentError
    # end 
  end 


  describe "#select_channel(user_input)" do 
    before do 
      VCR.use_cassette("channels-list-endpoint") do 
        @workspace = Slack::Workspace.new()
      end 
    end 

    it "returns a channel as recipient if I supply a channel name" do 
      name = "random"
      channel = @workspace.select_channel(name)

      expect(channel).must_be_kind_of Slack::Channel
      expect(channel.name).must_equal name
    end 

    it "returns a channel as recipient if I supply a slack_id" do 
      id = "CV86T0TPY"
      channel = @workspace.select_channel(id)

      expect(channel).must_be_kind_of Slack::Channel
      expect(channel.slack_id).must_equal id
    end 

    # it "raises an ArgumentError if no channel found" do 
    #   name = "my fur baby"
    #   expect{@workspace.select_channel(name)}.must_raise ArgumentError
    # end 
  end 


  describe "#show_details" do 
    before do 
      VCR.use_cassette("users-list-and-channels-list-endpoint") do 
        @workspace = Slack::Workspace.new()
      end 
    end 

    it "returns the selected user details" do 
      id = "USLACKBOT"

      # Invoke #select_user to assign "selected" variable
      @workspace.select_user(id)

      expect(@workspace.show_details).must_be_kind_of TablePrint::Returnable
    end 
  end 
end 