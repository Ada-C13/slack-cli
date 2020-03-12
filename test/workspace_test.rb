require_relative 'test_helper'
require_relative '../lib/workspace'

describe "initialize" do 

  it "will create a workspace object" do 
    workspace = Workspace.new
    workspace.must_be_instance_of Workspace
  end 

  # it "can return all users" do 
  #   VCR.use_cassette("user_data") do
  #     workspace = Workspace.new
  #     users = workspace.list_users
  #     users.wont_be_nil
  #   end
  # end 




end 
