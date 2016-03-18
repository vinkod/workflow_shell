require_relative '../models/Command'

class GitRebase < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'grb'
    @command_description = 'Takes one argument, the number of commits to rebase. Rebases interactively with the given number.'
    @command_usage = @command_string + " <number of commits to rebase>"
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments)

    commits_to_rebase = parser_components.leftover_arguments.pop
    if commits_to_rebase.nil?
      puts "You MUST specify the number of commits to rebase!"
      puts ""
      puts parser_components.basic_options_printer
      exit(-1)
    end

    command = "git rebase -i HEAD~#{commits_to_rebase}"
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end