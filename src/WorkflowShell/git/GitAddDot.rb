require_relative '../models/Command'

class GitAddDot < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'gad'
    @command_description = 'Stages all files and folders in the current directory.'
    @command_usage = @command_string
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, true)

    command = "git add ."
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end