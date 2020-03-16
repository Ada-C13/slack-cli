require_relative "test_helper"
require_relative "../lib/channel"

describe "channel" do

  describe "initialize" do
    # it creates a channel object 
    # instance has an ID
    # instance has a name
    # instance has a topic
    # instance has a member count
    # instance type is :CHANNEL
  end

  describe "get_all" do
    # must raise exception when endpoint returns failure 
    # returns an array of channels 
    # array of channels must be of expected length
    # one of the channels must be the General channel
  end

  describe "list_all" do
    # regex matches the General channel details
  end


end