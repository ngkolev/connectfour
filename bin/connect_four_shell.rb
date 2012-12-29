require_relative '../lib/connect_four/connect_four_shell/shell'

shell = ConnectFour::ConnectFourShell::Shell.new
shell.on_exit { exit }

loop do
  print 'CONNECT FOUR> '
  input = gets.chomp.strip
  next if input == ''
  puts shell.invoke(input)
  puts
end