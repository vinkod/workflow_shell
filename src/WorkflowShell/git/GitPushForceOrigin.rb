require_relative '../models/Command'

class GitPushForceOrigin < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'gpfo'
    @command_description = 'Force pushes the current branch into a remote branch of the same name.'
    @command_usage = @command_string
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, true)

    get_branch_command = "git rev-parse --abbrev-ref HEAD"
    branch_name = run_shell_command_with_output(get_branch_command, parser_components.basic_options.verbose)

    command = "git push -f origin #{branch_name}"
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end