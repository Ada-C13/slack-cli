require_relative 'test_helper'

describe 'instantiates a user' do
  
  it 'user object properties' do
    new_user = User.new('U0G9QF9C6', "Cherdonna", "Cherdonna Shinatra", "Worth My Salt", "🤡")
    
    expect(new_user).must_be_instance_of User
    expect(new_user.slack_id).must_equal 'U0G9QF9C6'
    expect(new_user.name).must_equal "Cherdonna"
    expect(new_user.real_name).must_equal "Cherdonna Shinatra"
    expect(new_user.status_text).must_equal "Worth My Salt"
    expect(new_user.status_emoji).must_equal "🤡"
  end
  
end