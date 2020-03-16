require 'table_print'

require_relative 'recipient'

#module Slack 
  class User < Recipient
    attr_reader :real_name
  
    def initialize (id, name, real_name)
      super(id, name)
      @real_name = real_name

      if @id == nil || @name == nil || @real_name == nil 
        raise ArgumentError, "arguments can't be nil"
      end
    end

    def details
      puts "Username: #{@name}"
      puts "Name: #{@real_name}"
      puts "Id: #{@id}"
    end
  end
#end
