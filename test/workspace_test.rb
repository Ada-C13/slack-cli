require_relative 'test_helper'
require_relative '../lib/workspace'
require_relative '../lib/channel'
require_relative '../lib/user'


describe "initialize" do 

  it "will create a workspace object" do 
    workspace = Workspace.new
    workspace.must_be_instance_of Workspace

    


  end 




end 
