require_relative '../models/Command'

class ProductionSSHLogin < Command
  @command_string
  @command_description
  @command_usage = @command_string

  def initialize
    @command_string = 'prodportal'
    @command_description = "Logs into a production utility node via a portal."
    @command_usage = @command_string + " <options>"
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, false)

    # Parse any specific options and print help if necessary.
    specific_options = OpenStruct.new
    specific_options.gate = "ssh.cernersphere.com"
    specific_options.node = "44.128.68.235"
    specific_options.pin = "INVALID"
    specific_options.password = "1234"
    specific_options_parser = OptionParser.new do |opts|
      opts.banner = ""
      opts.separator  "Specific options: "

      opts.on("-g", "--gate", "The portal to connect to first.") do
        specific_options.skip_tests = true
      end

      opts.on("-n", "--node", "The utility node that should be connected to after successfully connecting to the portal.") do
        specific_options.quiet = true
      end

      opts.on("-pn", "--pin", "Your production RSA pin.") do
        specific_options.upload = true
      end

      opts.on("-pw", "--password", "Build with multiple threads.") do
        specific_options.fast = true
      end

      if parser_components.basic_options.help
        puts parser_components.basic_options_printer
        puts opts
        exit
      end

    end

    specific_options_parser.parse!(parser_components.leftover_arguments)

    # Base command
    token_script_command = "osascript GetToken.scpt "

    if specific_options.pin != "INVALID"
      token_script_command += specific_options.pin
    else
      print_help(parser_components.basic_options_printer, specific_options_parser)
    end

    run_shell_command(token_script_command, parser_components.basic_options.verbose)

  end
end