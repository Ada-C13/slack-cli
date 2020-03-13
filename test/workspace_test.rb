require_relative "test_helper"

describe "Wave1" do
  describe "initialize" do 
    it "can create new instance of Workspace" do
      VCR.use_cassette("workspace_initialization") do
        response = SlackApi::Workspace.new
        
        expect(response).must_be_kind_of SlackApi::Workspace
      end
    end
  end
end






  
 
  