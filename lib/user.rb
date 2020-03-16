module Slack
  class User
    
    def initialize(user)
      @id
      @user_name
      @real_name
    end


    # CLASS METHODS

    # Method uses http get to retrieve all User "objects"
    def self.get_all
      # httparty GET 
      # API endpoint https://slack.com/api/users.list?
    end

    # Method takes the results of get_all and pretty-prints them.
    def self.list_all

    end

  end
end