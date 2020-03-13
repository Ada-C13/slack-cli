require_relative "test_helper"

describe 'Workspace class' do
  describe 'initializing Users and Channels' do
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

  describe 'selecting a User or Channel' do
    it 'should return selected User if found, or nil otherwise' do
      VCR.use_cassette("users") do
        new_workspace = Workspace.new
        expect(new_workspace.select_user("slackbot")).must_equal new_workspace.selected
        expect(new_workspace.select_user("USLACKBOT")).must_equal new_workspace.selected
        expect(new_workspace.select_user("who")).must_equal nil
      end
    end

    it 'should return selected Channel if found, or nil otherwise' do
      VCR.use_cassette("channels") do
        new_workspace = Workspace.new
        expect(new_workspace.select_channel("random")).must_equal new_workspace.selected
        expect(new_workspace.select_channel("CV86RT7AS")).must_equal new_workspace.selected
        expect(new_workspace.select_channel("who")).must_equal nil
      end
    end
  end

  describe 'message method' do
    it 'should return the sent message' do
    end
  end
end