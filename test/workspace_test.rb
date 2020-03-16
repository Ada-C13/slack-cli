require_relative "test_helper"
require_relative "../lib/workspace"

describe "workspace" do

  describe "initialize" do
    # raises error for bad endpoint response
    # creates a workspace object
    # @users is an array of user objects
    # @channels is an array of channel objects
    # @selected is initialized to nil
  end

  describe "select conversation" do
    # raises an error when given invalid convo ID
    # sets @selected to the specified conversation
  end

  describe "show details" do
    # raises an error when given invalid convo ID
  end

  describe "post message" do
    # raises an error when given invalid convo ID
  end
  

end