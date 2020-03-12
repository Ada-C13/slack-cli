require_relative "test_helper"

require 'httparty'


describe "getting number of channels" do

  it "can get number of channels" do
    VCR.use_cassette("channels") do
      response = Workspace.new
  
      expect(response.channels).wont_be_nil
      expect(response.num_of_channels).must_equal 5
    end
    
  end   
   
end

describe "getting number of users" do

  it "can get number of users" do
    VCR.use_cassette("users") do
      response = Workspace.new
     
      expect(response.users).wont_be_nil
      expect(response.num_of_users).must_equal 8
    end 
  end  
end

xdescribe "listing users" do

  it "outputs list of users" do
    VCR.use_cassette("users.list") do
      response = Workspace.new

      expect(SWorkspace.new.list_users(response)).must_be_kind_of String
    end
  end 
end
