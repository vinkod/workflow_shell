require_relative '../models/Command'

class GitSetUpstream < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'gitup'
    @command_description = 'Sets the target upstream branch.'
    @command_usage = @command_string
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, true)

    get_branch_command = "git rev-parse --abbrev-ref HEAD"
    branch_name = run_shell_command_with_output(get_branch_command, parser_components.basic_options.verbose).to_s.strip

    command = "git branch --set-upstream-to origin/#{branch_name}"
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end