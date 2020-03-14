require_relative "test_helper"

describe "Recipient class" do
  describe 'Recipient instantiation' do
    before do
      @recipient = Recipient.new(slack_id: "CV5KNMDKN", name: "slack-cli")
    end
    
    it "is an instance of Recipient" do
      expect(@recipient).must_be_kind_of Recipient
    end

    it "is set up for specific attributes and data types" do
      [:slack_id, :name].each do |prop|
        expect(@recipient).must_respond_to prop
      end
      
      expect(@recipient.name).must_be_kind_of String
      expect(@recipient.slack_id).must_be_kind_of String

    end
  end
  
  describe 'Recipient instantiation' do
    it 'self.list_all' do
      expect{Recipient.list_all}.must_raise NotImplementedError
    end
  end
  



end


