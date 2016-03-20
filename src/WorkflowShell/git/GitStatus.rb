require_relative '../models/Command'

class GitStatus < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'gs'
    @command_description = 'Displays the current status of the git repository.'
    @command_usage = @command_string
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, true)

    command = "git status"
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end