require_relative 'test_helper'

describe 'initialize' do
  
  
  it 'instantiates a workspace object' do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      expect(@workspace).must_be_instance_of Workspace
      expect(@workspace).must_respond_to :users
    end
  end
  
  it 'contains an array of user objects' do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.users[0]).must_be_instance_of User
    end 
  end
  
  it 'contains an array of channel objects' do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      expect(@workspace.channels).must_be_kind_of Array
      expect(@workspace.channels[0]).must_be_instance_of Channel
    end
  end
  
  it 'initial value of selected is nil' do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      expect(@workspace.selected).must_be_nil
    end
  end
end



# describe 'list channels' do
#   before do
#     @workspace = Workspace.new
#   end

#   it 'can find channels' do
#     VCR.use_cassette('list_channels') do
#       channels = @workspace.list_channels

#       expect(channels).must_be_kind_of Array
#       expect(channels.length).must_equal 3
#       expect(channels).must_equal ["general", "api-testing", "random"]
#     end
#   end

# end
