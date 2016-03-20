
class GitPretty < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'gitpretty'
    @command_description = 'Displays the git log with each commit taking only one line.'
    @command_usage = @command_string
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, true)

    command = "git log --pretty=oneline"
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end