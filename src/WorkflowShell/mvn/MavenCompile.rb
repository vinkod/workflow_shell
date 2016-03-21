require_relative '../models/Command'

class MavenCompile < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'mvncompile'
    @command_description = 'Updates, cleans, compiles, and compiles tests.'
    @command_usage = @command_string
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, true)

    command = "mvn -U -T 3C clean compile test-compile -Djava.awt.headless=true"
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end