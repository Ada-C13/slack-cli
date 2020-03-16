require_relative 'test_helper'
require 'httparty'
require 'dotenv'
require 'stringio'
require 'table_print'

Dotenv.load

describe "workspace Class" do

  describe "Workspace instantiation" do
    before do
      VCR.use_cassette("initialize") do
        @workspace = SlackCli::Workspace.new(users: SlackCli::User.list_all,channels: SlackCli::Channel.list_all,selected: nil)
      end
    end

    it "is an instance of Workspace" do
      VCR.use_cassette("initialize") do
        expect(@workspace).must_be_kind_of SlackCli::Workspace
      end
    end
    
    it "can list all channels in the workspace" do
      VCR.use_cassette("list all channels") do
        expect(@workspace.channels.length).must_equal 4
      end
    end
    
    it "can list all users in the workspace" do
        VCR.use_cassette("list all users") do
          expect(@workspace.users.length).must_equal 11
        end
      end

    it "can select a channel correctly" do
        VCR.use_cassette("select channel") do
            string_io = StringIO.new               
            string_io.puts 'CVDP09BL7'
            string_io.rewind 
            $stdin = string_io   
       
            
            @workspace.select_channel     
            $stdin = STDIN          
            expect(@workspace.selected.name).must_equal "halatests"
        end
    end

    it "can select a user correctly" do
        VCR.use_cassette("select user") do
            string_io = StringIO.new               
            string_io.puts 'UV868PVCP'
            string_io.rewind 
            $stdin = string_io   
       
            
            @workspace.select_user    
            $stdin = STDIN          
            expect(@workspace.selected.name).must_equal "h.m.haddad"
        end
    end

    it "must show details of a user or channel" do
        VCR.use_cassette("show details") do
            string_io = StringIO.new               
            string_io.puts 'UV868PVCP'
            string_io.rewind 
            $stdin = string_io   
            
            @workspace.select_user    
            $stdin = STDIN         
        expect(@workspace.show_details).must_equal @workspace.selected.details
        end
    end

    it "can send a message to a user" do
        VCR.use_cassette("send messages") do
            string_io = StringIO.new 
            string_io.puts 'user'              
            string_io.puts 'UV868PVCP'
            string_io.puts 'asdfas'
            string_io.rewind 
            $stdin = string_io   
       
            
            message = @workspace.send_message    
            $stdin = STDIN          
            expect(message).must_equal true && 200
        end
    end

    it "can send a message to a channel" do
        VCR.use_cassette("send messages") do
            string_io = StringIO.new 
            string_io.puts 'channel'              
            string_io.puts 'CVDP09BL7'
            string_io.puts 'asdfas'
            string_io.rewind 
            $stdin = string_io   
            
            message = @workspace.send_message    
            $stdin = STDIN          
            expect(message).must_equal true && 200
        end
    end

  end
end