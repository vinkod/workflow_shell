require_relative '../models/Command'
require_relative 'GitCommitAllMessage'
require_relative 'GitRebase'
require_relative 'GitAmend'
require_relative 'GitPushForceOrigin'

class GitGo < Command
  @command_string
  @command_description
  @command_usage = @command_string

  def initialize
    @command_string = 'gitgo'
    @command_description = "Runs 'grb'. Commits all staged changes, rebases interactively, amends the most recent commit, then force pushes."
    @command_usage = @command_string + " <number of commits to rebase>"
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments)

    # Parse any specific options and print help if necessary.
    specific_options_parser = OptionParser.new do |opts|
      opts.banner = "Usage: " + @command_string + " <amount of commits to rebase>"
      opts.separator "There are no specific options for this command."

      if parser_components.basic_options.help
        puts parser_components.basic_options_printer
        puts opts
        exit
      end
    end
    specific_options_parser.parse!(arguments)

    commits_to_rebase = parser_components.leftover_arguments.pop
    if commits_to_rebase.nil?
      puts "You MUST specify the number of commits to rebase!"
      puts ""
      puts parser_components.basic_options_printer
      exit(-1)
    end

    GitCommitAllMessage.new.run_command(["test commit, please squash"])
    GitRebase.new.run_command([commits_to_rebase])
    GitAmend.new.run_command([])
    GitPushForceOrigin.new.run_command([])
  end
end