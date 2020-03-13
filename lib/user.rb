require_relative 'recipient'

module SlackApi
  class User < Recipient

    attr_reader :real_name, :slack_id, :name

    def initialize(
      slack_id:,
      name:,
      real_name:
    )

    super(slack_id: slack_id, name: name)


      @real_name = real_name
      # @status_text = status_text
      # @status_emoji = status_emoji 

    end # initialize end


    # def show_details
    # end
    
  

  end #class end
  
end #module end




