# !/usr/bin/env ruby


def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  
  puts "Here are some details about your slack workspace:"
  puts "Your workspace has #{num_channels} channels, and #{num_users} users."
  
  # method: get_choices
  
  puts "What would you like to do?"
  puts "You can choose: List Users, List Channels, Quit"
  print "So, what'll it be? ==> "
  user_choice = gets.chomp.downcase
  
  if user_choice == "list users"
    # run list users method
    # list users should be in workspace
  elsif user_choice == "list channels"
    # run list channels method
    # list channels should be in workspace
  elsif user_choice == "quit"
    # exit program
  end
  
  # after program starts, autolist users and channels
  # display choices [list users, list channels, quit]
  
  # after user makes a choice, display that information
  # re-display choices to ask for more input
  
  puts "Thank you for using the Ada Slack CLI"
end


# def get_choice
#   puts "What would you like to do?"
#   puts "Options: List Users, List Channels, Quit ==> "
#   user_choice = gets.chomp.downcase
#   user_choice = valid_input(user_choice)
#   return user_wants_to(user_choice)
# end


# def valid_input
#   valid_choice = ["users", "channels", "list users", "list channels", "quit"]
#   until valid_choice.include? user_choice
#     puts "That doesn't look like a valid choice..."
#     puts "You can enter: list users, list channels, or exit."
#     print "So what'll it be? ==> "
#     user_choice = gets.chomp.downcase
#   end
# end


# def user_wants_to

# end

main if __FILE__ == $PROGRAM_NAME