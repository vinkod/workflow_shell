require_relative '../models/Command'

class GitAddDot < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'gitfixignore'
    @command_description = 'Attempts to fix gitignore not working properly.'
    @command_usage = @command_string
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, true)

    run_shell_command("git commit -a -m \"Before Fixing gitignore\"", parser_components.basic_options.verbose)
    run_shell_command("git rm -r --cached .", parser_components.basic_options.verbose)
    run_shell_command("git add .", parser_components.basic_options.verbose)
    run_shell_command("git commit -a -m \"Fixed gitignore\"", parser_components.basic_options.verbose)
  end
end