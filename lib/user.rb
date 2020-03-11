require_relative 'recipient'


class User < Recipient

  def initialize(slack_id:,name:,real_name:)
    super(slack_id,name)
    @real_name = real_name
  end

  def self.get(url,params)
    data = HTTParty.get(url,query: params)["members"]
    empty_array = []
    data.each do |member|
      empty_array << new(slack_id: member["id"], name: member["name"], real_name:member["real_name"])
    end 
    return empty_array 

  end 
 
end