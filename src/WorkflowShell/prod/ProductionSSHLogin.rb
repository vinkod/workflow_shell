require_relative '../models/Command'

class ProductionSSHLogin < Command
  @command_string
  @command_description
  @command_usage = @command_string

  def initialize
    @command_string = 'prodssh'
    @command_description = "Logs into a production utility node via a portal. More information about portals can be found here: https://wiki.ucern.com/pages/viewpage.action?pageId=1235753143"
    @command_usage = @command_string + " <options>"
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, false)

    # Parse any specific options and print help if necessary.
    specific_options = OpenStruct.new
    specific_options.gateway = "ssh.cernersphere.com"
    specific_options.node = "44.128.68.235"
    specific_options.token_code = nil
    specific_options.password = nil
    specific_options_parser = OptionParser.new do |opts|
      opts.banner = ""
      opts.separator  "Specific options: "

      opts.on("-g", "--gateway GATEWAY", String, "OPTIONAL. Default is, \"#{specific_options.gateway}\". The gateway/portal to connect to first.") do |gateway|
        specific_options.gateway = gateway
      end

      opts.on("-n", "--node NODE_IP", String, "OPTIONAL. Default is, \"#{specific_options.node}\". The utility node that should be connected to after successfully connecting to the portal.") do |node|
        specific_options.node = node
      end

      opts.on("-t", "--tokencode TOKEN_CODE", String, "REQUIRED. An RSA tokencode generated with your PIN.") do |token_code|
        specific_options.token_code = token_code
      end

      opts.on("-p", "--password PROD_PASSWORD", String, "REQUIRED. Build with multiple threads.") do |password|
        specific_options.password = password
      end

      if parser_components.basic_options.help
        puts parser_components.basic_options_printer
        puts opts
        exit
      end
    end

    specific_options_parser.parse!(parser_components.leftover_arguments)

    # Check required parameters.
    token_code = nil
    if specific_options.token_code != nil
      token_code = specific_options.token_code
    else
      puts("You MUST enter a token.")
      print_help(parser_components.basic_options_printer, specific_options_parser)
    end

    password = nil
    if specific_options.password != nil
      password = specific_options.password
    else
      puts("You MUST enter a password.")
      print_help(parser_components.basic_options_printer, specific_options_parser)
    end

    # Print a warning telling people not to press buttons while this is running.
    print_interactivity_warning
    @script_home = File.expand_path(File.dirname(__FILE__))

    get_to_token_prompt_command = "osascript #{@script_home}/ProdSSHWithClipboard.scpt \"#{specific_options.gateway}\" \"#{specific_options.node}\" \"#{password}\" \"#{token_code}\""
    run_shell_command(get_to_token_prompt_command, false)
  end
end