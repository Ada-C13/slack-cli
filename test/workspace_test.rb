require_relative 'test_helper'

describe 'Workspace' do 
  describe 'constructor' do
    before do
      @workspace = Workspace.new
    end
    it 'creates instance of Workspace' do
      expect(@workspace).must_be_kind_of Workspace
    end
    it 'has state @users and @channels' do
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.channels).must_be_kind_of Array
    end
  end
end