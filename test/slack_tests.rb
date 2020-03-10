require_relative 'test_helper'

describe "Slack Test" do
  before do 
    list_of_names = list_users()
  end

  describe 'list out all users' do
    it 'first user is listed out correctly' do
      expect(list_of_names.first).must_equal 'Jocelyn Wang'
    end

    it 'last user is listed out correctly' do
      expect(list_of_names.last).must_equal 'Jocelyn Wang'
    end

    it 'list of users should include...' do
      expect(list_of_names).must_include 'Jocelyn Wang'
    end

    it 'correct number of users returned' do
      expect(list_of_names.length).must_equal 1
    end

  end


  # list out all users 
  # first user should be XXX
  # last user should be XXX
  # OR users should include... list of names
  # number of user should be X
  
  # list out all channels
  # first channels should be XXX
  # last channels should be XXX
  # OR channels should include... list of channels
  # number of channels should be

  # user can exit out of program
  # after command "quit" is entered, unable to interact with interface anymore


  # Messages are sent from bot
end