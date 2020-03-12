require_relative "test_helper"

describe "Workspace class" do 

  # Question: I cannot use `before block` here?
  # Because when I try to access it inside of `VCR.use_cassette`, it gives me an error
  # before do 
  #   @workspace = Slack::Workspace.new()
  # end 


  describe "#initialize" do
    it "creates a `users` array and return all users' list" do 
      VCR.use_cassette("workspace attributes") do 

        users = Slack::Workspace.new().users
        channels = Slack::Workspace.new().channels

        expect(users).must_be_kind_of Array
        expect(channels).must_be_kind_of Array

        expect(users[0]).must_be_kind_of Slack::User 
        expect(channels[0]).must_be_kind_of Slack::Channel
      end 
    end  
  end 
end 