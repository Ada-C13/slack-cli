require_relative 'workspace'

def select(input, workspace)
  input = input.split(" ")[1]
  selected = workspace.select(input)
  puts "Enter the Slack ID, channel name, or username of the recipient."
  input = gets.chomp
  selected = selected.find {|recipient| recipient.name == input || recipient.slack_id == input}
  if selected == nil
    puts "Recipient not found."
  else
    puts "#{selected.class} #{selected.name} selected."
  end
  return selected
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts "This workspace has #{workspace.users.length} users and #{workspace.channels.length} channels."
  input = ""
  selected = nil
  while input != "quit"
    puts "\nWhat would you like to do?"
    puts "list users \nlist channels \nselect user \nselect channel \ndetails \nquit \n\n"
    input = gets.chomp.downcase
    case input 
    when "list users"
      workspace.print_list("users")
    when "list channels"
      workspace.print_list("channels")
    when "select user"
      selected = select(input, workspace)
    when "select channel"
      selected = select(input, workspace)
    when "details"
      if selected == nil
        puts "You must select a recipient before asking for details."
      else
        # TO DO; refactor details so that table print can be used
        ap selected.details
      end
    when "quit"
      puts "Goodbye!"
    else
      puts "Oops, that's not valid input."
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME