require_relative "test_helper"

describe "Recipient class" do

  describe 'Recipient instantiation' do
    it 'self.list_all' do
      expect{Recipient.list_all}.must_raise NotImplementedError
    end
  end
end


