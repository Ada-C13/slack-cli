require_relative "test_helper"
require "simplecov"

describe "User class" do
  it "creates a user" do
    #Arrange
    name = "Hannah"
    id = "0317"

    #Act
    user = User.new(name, id)
    #Assert
    expect(user).must_be_instance_of User
  end
end
