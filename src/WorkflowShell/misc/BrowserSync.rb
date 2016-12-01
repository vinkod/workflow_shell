require_relative '../models/Command'

class BrowserSync < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'bs'
    @command_description = 'Starts up BrowserSync with normal options.'
    @command_usage = @command_string
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, true)

    command = "browser-sync start --server --directory --files \"**/*\""
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end