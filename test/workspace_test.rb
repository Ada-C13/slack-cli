require_relative "test_helper"

describe 'Workspace class' do
  it 'should make many instances of User' do
    VCR.use_cassette("users") do
      new_workspace = Workspace.new
      expect(new_workspace.users).must_be_instance_of Array
      expect(new_workspace.users[0]).must_be_instance_of User
    end
  end

  it 'should make many instances of Channel' do
    VCR.use_cassette("channels") do
      new_workspace = Workspace.new
      expect(new_workspace.channels).must_be_instance_of Array
      expect(new_workspace.channels[0]).must_be_instance_of Channel
    end
  end
end