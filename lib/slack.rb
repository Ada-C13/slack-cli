require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts "This workspace has #{workspace.users.length} users and #{workspace.channels.length} channels."
  input = ""
  # TO DO: refactor to meet requirements of typing out options (wave 1)
  while input != "quit"
    puts "\nWhat would you like to do?"
    puts "list users \nlist channels \nquit"
    input = gets.chomp.downcase
    case input 
    when "list users"
      workspace.print_list("users")
    when "list channels"
      workspace.print_list("channels")
    when "quit"
      puts "Goodbye!"
    else
      puts "Oops, that's not valid input."
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME