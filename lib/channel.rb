require_relative "recipient"

class Channel < Recipient
  attr_reader :num_members, :topic

  def initialize(id, name, num_members, topic)
    super(id, name)
    
    @num_members = num_members
    @topic = topic

    if @id == nil || @name == nil || @num_members == nil || @topic == nil 
      raise ArgumentError, "arguments can't be nil"
    end
  end

  def details
    puts "Name: #{@name}"
    puts "Topic: #{@topic}"
    puts "Number of Members: #{@num_members}"
    puts "Channel ID: #{@id}"
  end
end