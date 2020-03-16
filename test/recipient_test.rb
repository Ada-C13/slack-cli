require_relative "test_helper"

describe "constructor" do
  before do
    @slack_id = "RN123"
    @name = "name"
    @recipient = Recipient.new(slack_id: @slack_id, name: @name)
  end
  it "instance of recipient class" do
    expect (@recipient).must_be_instance_of Recipient
  end
  it "can access attributes"do
      expect(@name).must_equal @name
      expect(@slack_id).must_equal @slack_id
    end
end