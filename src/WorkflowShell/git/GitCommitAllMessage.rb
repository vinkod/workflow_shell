require_relative '../models/Command'

class GitCommitAllMessage < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'gcam'
    @command_description = 'Takes one argument, the message. Commits all staged changes with the given message.'
    @command_usage = @command_string + " <Commit Message>"
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments)

    commit_message = parser_components.leftover_arguments.pop
    if commit_message.nil?
      puts "You MUST specify the commit message!"
      puts ""
      puts parser_components.basic_options_printer
      exit(-1)
    end

    command = "git commit --all --message \"#{commit_message}\""
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end