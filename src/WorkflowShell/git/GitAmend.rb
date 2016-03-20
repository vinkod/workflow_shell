require_relative '../models/Command'

class GitAmend < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'gitamend'
    @command_description = 'Amends the most recent commit to ensure that it has the correct author and an updated timestamp.'
    @command_usage = @command_string
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, true)

    command = "git commit --amend --reset-author --no-edit"
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end