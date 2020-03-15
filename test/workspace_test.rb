require "table_print"
require_relative "test_helper"
require_relative "../lib/workspace"

describe 'Workspace class' do
  describe 'initializing Users and Channels' do
    it 'should make many instances of User' do
      VCR.use_cassette("users-list-endpoint") do
        new_workspace = Workspace.new
        expect(new_workspace.users).must_be_instance_of Array
        expect(new_workspace.users[0]).must_be_instance_of User
      end
    end

    it 'should make many instances of Channel' do
      VCR.use_cassette("channels-list-endpoint") do
        new_workspace = Workspace.new
        expect(new_workspace.channels).must_be_instance_of Array
        expect(new_workspace.channels[0]).must_be_instance_of Channel
      end
    end
  end

  describe 'selecting a User or Channel' do
    it 'should return selected User if found, or nil otherwise' do
      VCR.use_cassette("users-list-endpoint") do
        new_workspace = Workspace.new
        expect(new_workspace.select_user("slackbot")).must_equal new_workspace.selected
        expect(new_workspace.select_user("USLACKBOT")).must_equal new_workspace.selected
        expect(new_workspace.select_user("who")).must_equal nil
      end
    end

    it 'should return selected Channel if found, or nil otherwise' do
      VCR.use_cassette("channels-list-endpoint") do
        new_workspace = Workspace.new
        expect(new_workspace.select_channel("random")).must_equal new_workspace.selected
        expect(new_workspace.select_channel("CV86RT7AS")).must_equal new_workspace.selected
        expect(new_workspace.select_channel("who")).must_equal nil
      end
    end
  end

  describe 'new_message method' do
    it 'should return the sent message' do
      VCR.use_cassette("chat-postMessage-endpoint") do
        new_workspace = Workspace.new  
        random = new_workspace.select_channel("random")
        message = new_workspace.new_message("This is a message")
        expect(message).must_be_kind_of HTTParty::Response
        expect(message["ok"]).must_equal true
        expect(message["message"]["text"]).must_equal "This is a message"
        end
      end
  end

  describe 'show_details' do
    it 'should show the details of a user' do
      VCR.use_cassette("users-list-endpoint") do
        new_workspace = Workspace.new
        new_workspace.select_user("USLACKBOT")
        expect(new_workspace.show_details).must_respond_to :details
      end
    end

    it 'should show the details of a channel' do
      VCR.use_cassette("channels-list-endpoint") do
        new_workspace = Workspace.new
        new_workspace.select_channel("random")
        expect(new_workspace.show_details).must_respond_to :details
      end
    end
  end
end