require_relative "test_helper"

describe "WorkSpace class" do
  describe 'WorkSpace instantiation' do
    before do
      @workspace = WorkSpace.new
    end
    
    it "is an instance of User" do
      expect(@workspace).must_be_kind_of WorkSpace
    end

    it "is set up for specific attributes and data     types" do
      [:users, :channels, :selected].each do |prop|
        expect(@workspace).must_respond_to prop
      end
      
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.channels).must_be_kind_of Array
      expect(@workspace.selected).must_equal nil
    end
  end
end
