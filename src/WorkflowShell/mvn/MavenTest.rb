require_relative '../models/Command'

class MavenTest < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'mvntest'
    @command_description = 'Takes one argument, the name of a class which contains tests. Updates, then attempts to run all specified tests.'
    @command_usage = @command_string + " <Test Class Name>"
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, false)

    test_name = parser_components.leftover_arguments.pop
    if test_name.nil?
      puts "You MUST specify the test name!"
      puts ""
      print_help(parser_components.basic_options_printer, nil)
    end

    command = "mvn -U -Dtest=#{test_name} test -Djava.awt.headless=true"
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end