#00 ride share csvrecord
module SlackCli
  class Recipient
    attr_reader :id 
    attr_accessor :name

    def initialize(id, name)
      @id = id
      @name = name
    end #initialize
  end #class
end #module