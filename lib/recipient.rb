#00 ride share csvrecord
module SlackCli
  class Recipient
    attr_reader :id 
    attr_accessor :name

    def initialize(id, name)
      @id = id
      @name = name
    end #initialize

    private
    def self.load_all() #abstract method/template
      raise NotImplementedError, 'Implement me in a child class!'
    end
  end #class
end #module
