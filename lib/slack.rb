# #!/usr/bin/env ruby
# require 'table_print'



# def list_options 
#   puts "Choose an option: "
#   puts "1 - list of users"
#   puts "2 - list of channels"
#   puts "3 - select user"
#   puts "4 - select channel"
#   puts "or enter quit"
# end 

# def main
#   puts "Welcome to the Ada Slack CLI!"
#   workspace = SlackApp::Workspace.new

#   # TODO project
   
#   list_options()


#   get_option = gets.chomp.downcase
#   until  ["1", "2", "3", "4", "quit"].include?(get_option)
#     puts "Please enter a valid option:"
#     get_option = gets.chomp.downcase 
#   end 

#   case recipient
#     when "1"
#       workspace.users #will give them a list of users 
#     when "2"
#       workspace.channels #will give them a list of users 
#     when "3"
#       puts "Enter the user slack id or user name"
#       user_id_name = gets.chomp.downcase 
      
#     when "4"
#       puts

#   puts "Thank you for using the Ada Slack CLI"
# end

# main if __FILE__ == $PROGRAM_NAME