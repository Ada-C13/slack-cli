require_relative "test_helper"
require_relative '../lib/user'

describe ".list_all" do
  it "provides instances of User class" do
    users = []
    VCR.use_cassette("users") do
      users = SlackCLI::User.list_all
    end
    
    expect(users.first).must_be_instance_of SlackCLI::User
    expect(users.last).must_be_instance_of SlackCLI::User
  end 
end