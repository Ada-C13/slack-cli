require_relative "test_helper"
describe Channel do

  describe 'constructor' do
    
    it "Creates an instance of reservation" do
      slack_id = "CV5KNMDKN"
      name = "slack-cli"
      recipiant = Recipiant.new("CV5KNMDKN", "slack-cli")
      recipiant.must_be_kind_of Recipiant
    end

    it 'Keep treck of selck_id' do
      name = "slack-cli"
      slack_id = "CV5KNMDKN"
      recipiant = Recipiant.new(slack_id, name)
      recipiant.must_respond_to :slack_id
      recipiant.slack_id.must_equal slack_id
    end

    it 'Keep treck of slack name' do
      name = "slack-cli"
      slack_id = "CV5KNMDKN"
      recipiant = Recipiant.new(slack_id, name)
      recipiant.must_respond_to :name
      recipiant.name.must_equal name
    end
  end