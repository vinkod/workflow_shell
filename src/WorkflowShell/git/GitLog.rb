
class GitLog < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'gitlog'
    @command_description = 'Displays the git log with each commit on one line in nice colors.'
    @command_usage = @command_string
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments)
    if parser_components.basic_options.help
      puts parser_components.basic_options_printer
      exit
    end

    command = "git reflog --pretty=format:'%Cred %H %Cgreen %gD %Cblue %s %C(Yellow) %aN'"
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end