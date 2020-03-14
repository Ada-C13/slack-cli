require_relative "test_helper"

describe "Wave1" do
  describe "initialize" do 
    it "can create new instance of Workspace" do
      VCR.use_cassette("workspace_initialization") do
        response = Workspace.new

        expect(response).must_be_kind_of Workspace
        expect(response.users).must_be_kind_of Array
        expect(response.channels).must_be_kind_of Array
      end
    end
  end
end






  
 
  