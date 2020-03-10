class Member
  attr_reader :name, :real_name, :id

  def initialize(name:,real_name:,id:)
    @name = name
    @real_name = real_name
    @id = id
  end
  
end