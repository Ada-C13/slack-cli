require_relative 'test_helper'

describe 'initialize' do
  before do
    @workspace = Workspace.new
  end

  it 'instantiates a workspace object' do
    expect(@workspace).must_be_instance_of Workspace
    expect(@workspace.users).must_be_kind_of Array
    expect(@workspace.channels).must_be_kind_of Array
  end


end