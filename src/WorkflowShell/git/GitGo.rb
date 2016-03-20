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
    parser_components = parse_options(arguments, false)

    commits_to_rebase = parser_components.leftover_arguments.pop
    if commits_to_rebase.nil?
      puts "You MUST specify the number of commits to rebase!"
      puts ""
      print_help(parser_components.basic_options_printer, nil)
    end

    GitCommitAllMessage.new.run_command(["test commit, please squash"])
    GitRebase.new.run_command([commits_to_rebase])
    GitAmend.new.run_command([])
    GitPushForceOrigin.new.run_command([])
  end
end