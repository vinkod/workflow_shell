require_relative '../models/Command'

class GetToken < Command
  @command_string
  @command_description
  @command_usage = @command_string

  def initialize
    @command_string = 'gettoken'
    @command_description = "Takes one argument, PIN. Uses SecurID to generate a production token."
    @command_usage = @command_string + " <PIN>"
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, false)

    production_pin = parser_components.leftover_arguments.pop
    if production_pin.nil?
      puts "You MUST specify your PIN!"
      puts ""
      print_help(parser_components.basic_options_printer, nil)
    end

    command = "osascript GetToken.scpt #{production_pin}"
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end