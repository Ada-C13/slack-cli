# module Slack 
  class Recipient
    attr_accessor :user_name, :user_id, :channel_name, :channel_id

    def initialize(user_name = nil, user_id = nil, channel_name = nil, channel_id = nil )
      @user_name = user_name
      @user_id = user_id
      @channel_name = channel_name
      @channel_id = channel_id
    end

    def self.create_recipient_from_name(name,type)
      recipient = Recipient.new
      if type == "user"
        recipient.user_name = name
      elsif type == "channel"
        recipient.channel_name = name 
      end

      return recipient
    end

    def self.create_recipient_from_id(id,type)
      recipient = Recipient.new
      puts type
      if type == "user"
        recipient.user_id = id
      elsif type == "channel"
        recipient.channel_id = id
      end
      return recipient
    end


    def self.details(recipient)
      
      if recipient.user_name != nil
        workspace = Workspace.new
        users = workspace.users
        users["members"].each do |member|
          if member["name"] == recipient.user_name
            puts member["name"]
            puts member["real_name"]
            puts member["id"]
          end
        end

      elsif @user_id != nil 
        workspace = Workspace.new
        users = workspace.users
        users["members"].each do |member|
          if member["id"] == recipient.user_id
            puts member["name"]
            puts member["real_name"]
            puts member["id"]
          end
        end
      elsif @channel_name != nil
        workspace = Workspace.new
        channels = workspace.channels
        channels["channels"].each do |channel|
          if channel["name"] == recipient.channel_name
            puts channel["topic"]["value"]
            puts channel["num_members"]
            puts channel["id"]
          end
        end
      elsif @channel_id != nil
        workspace = Workspace.new
        channels = workspace.channels
        puts "do you see me (self.details)?"
        channels["channels"].each do |channel|
          if channel["id"] == recipient.channel_id
            puts channel["topic"]["value"]
            puts channel["num_members"]
            puts channel["id"]
          end
        end
      end
    end
  end
# end