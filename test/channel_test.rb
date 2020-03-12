require_relative "test_helper"
describe Channel do
  describe 'constructor' do
    
    it "Creates an instance of channel" do
      topice = {}
      member_count = []
      channel = Channel.new({},[])
      channel.must_be_kind_of Channel
    end

    it 'Keep treck of topice' do
      topice = {}
      member_count = []
      channel = Channel.new(topice, member_count)
      channel.must_respond_to :topice
      expect(channel.topice).must_be_kind_of Hash
    end

    it 'Keep treck of slack member_count' do
      topice = {}
      member_count = []
      channel = Channel.new(topice, member_count)
      channel.must_respond_to :member_count
      expect(channel.member_count).must_be_kind_of Array
    end
  end
end