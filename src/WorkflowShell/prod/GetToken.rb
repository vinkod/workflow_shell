require_relative '../models/Command'

class GetToken < Command
  @command_string
  @command_description
  @command_usage = @command_string

  def initialize
    @command_string = 'gettoken'
    @command_description = "Takes one argument, PIN. Uses SecurID to generate a production token. " +
        "The token will be both the return value of this script and, as a side effect, " +
        "will end up on the keyboard as well."
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

    # Print a warning telling people not to press buttons while this is running.
    print_interactivity_warning
    @script_home = File.expand_path(File.dirname(__FILE__))

    command = "osascript #{@script_home}/GetToken.scpt #{production_pin}"
    run_shell_command(command, false)
  end
end