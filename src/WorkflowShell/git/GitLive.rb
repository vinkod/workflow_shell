require_relative '../models/Command'
require_relative 'GitCommitAllMessage'
require_relative 'GitPushForceOrigin'

class GitLive < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'gitlive'
    @command_description = 'Commits all staged changes, force pushes.'
    @command_usage = @command_string
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, true)

    GitCommitAllMessage.new.run_command(["test commit, please squash"])
    GitPushForceOrigin.new.run_command([])
  end
end