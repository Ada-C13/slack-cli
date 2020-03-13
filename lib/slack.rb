#!/usr/bin/env ruby

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  i = -1
  while i < 0
    puts "Your workspace has #{num_channels} channels and #{num_users} users."
    puts "--------------------"
    puts "What would you like to do? 'list channels', 'list users', or 'quit'"
    answer = gets.chomp.downcase
    if answer == "list channels"
      # puts workspace.list_channels (method that shows channels)
    elsif answer == "list users"
      # puts workspace.list_users
    elsif answer == "quit"
      i = 1
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

# {
#   "Our_channels" => {
#     :name => respnse[0]["channels"]["name"]
#   }
# }
# def main
#   puts "Welcome to the Ada Slack CLI!"
#   workspace = Workspace.new

#   # TODO project

#   puts "Thank you for using the Ada Slack CLI"
# end

# main if __FILE__ == $PROGRAM_NAME
