require_relative 'test_helper'


describe "Workspace" do 
  
  it "can be created" do 
    new_workspace = SlackApp::Workspace.new
    expect(new_workspace).must_be_kind_of SlackApp::Workspace
  end 
  
  describe "Initialize channels" do 
    before do 
      @new_workspace = SlackApp::Workspace.new
      @response = @new_workspace.channels
      
      
      
    end 
    it "can be loaded from the internet" do
      VCR.use_cassette("slack-workspace") do 
        
        puts "#{@new_workspace.initalize_channels } ****************************"
        expect(@response).must_be_kind_of Array    
      end
    end 
    
    # it "first channel is correct" do 
    #   VCR.use_cassette("slack-recipient") do 
    #     url = "channels.list"
    #     compare = SlackApp::Recipient.get(url)
    #     length_channels = compare["channels"].length - 1 
    #     expect(@response.length).must_equal length_channels
    #   end 
    
    # end 
  end 
  
  
  
end 