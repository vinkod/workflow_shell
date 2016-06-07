require_relative '../models/Command'

class ProductionSSHLogin < Command
  @command_string
  @command_description
  @command_usage = @command_string

  def initialize
    @command_string = 'prodssh'
    @command_description = "Logs into a production utility node via a portal."
    @command_usage = @command_string + " <options>"
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, false)

    # Parse any specific options and print help if necessary.
    specific_options = OpenStruct.new
    specific_options.gateway = "ssh.cernersphere.com"
    specific_options.node = "44.128.68.235"
    specific_options.pin = nil
    specific_options.password = nil
    specific_options_parser = OptionParser.new do |opts|
      opts.banner = ""
      opts.separator  "Specific options: "

      opts.on("-g", "--gateway GATEWAY", String, "The gateway/portal to connect to first.") do |gateway|
        specific_options.gateway = gateway
      end

      opts.on("-n", "--node NODE_IP", String, "The utility node that should be connected to after successfully connecting to the portal.") do |node|
        specific_options.node = node
      end

      opts.on("-i", "--pin PROD_PIN", String, "Your production RSA pin.") do |pin|
        specific_options.pin = pin
      end

      opts.on("-p", "--password PROD_PASSWORD", String, "Build with multiple threads.") do |password|
        specific_options.password = password
      end

      if parser_components.basic_options.help
        puts parser_components.basic_options_printer
        puts opts
        exit
      end
    end

    specific_options_parser.parse!(parser_components.leftover_arguments)

    pin = nil
    if specific_options.pin != nil
      pin = specific_options.pin
    else
      puts("You MUST enter a PIN.")
      print_help(parser_components.basic_options_printer, specific_options_parser)
    end

    password = nil
    if specific_options.password != nil
      password = specific_options.password
    else
      puts("You MUST enter a password.")
      print_help(parser_components.basic_options_printer, specific_options_parser)
    end

    @script_home = File.expand_path(File.dirname(__FILE__))

    get_to_token_prompt_command = "osascript #{@script_home}/GetToTokenPrompt.scpt \"#{password}\" \"#{specific_options.gateway}\""
    run_shell_command(get_to_token_prompt_command, parser_components.basic_options.verbose)

    token_script_command = "osascript #{@script_home}/GetToken.scpt \"#{pin}\""
    token = run_shell_command_with_output(token_script_command, parser_components.basic_options.verbose)

    continue_command = "osascript #{@script_home}/EnterTokenAndSSH.scpt \"#{token}\" \"#{specific_options.node}\" \"#{password}\""
    run_shell_command(continue_command, parser_components.basic_options.verbose)
  end
end