class Recipient
  #attr_accessor :user_name, :user_id, :channel_name, :channel_id
  attr_accessor :name, :id
  def initialize(name = nil, id = nil)
    @name = name
    @id = id
  end

  def self.create
    raise NotImplementedError
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