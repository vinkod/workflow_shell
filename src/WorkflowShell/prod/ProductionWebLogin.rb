require_relative '../models/Command'

class ProductionWebLogin < Command
  @command_string
  @command_description
  @command_usage = @command_string

  def initialize
    @command_string = 'prodweb'
    @command_description = "Logs into a production web portal."
    @command_usage = @command_string + " <options>"
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, false)

    # Parse any specific options and print help if necessary.
    specific_options = OpenStruct.new
    specific_options.webPortal = "https://access.cernersphere.com"
    specific_options.token_code = nil
    specific_options.password = nil
    specific_options_parser = OptionParser.new do |opts|
      opts.banner = ""
      opts.separator  "Specific options: "

      opts.on("-w", "--webportal WEB_PORTAL", String, "OPTIONAL. Default is, \"#{specific_options.webPortal}\". The web portal to open.") do |webPortal|
        specific_options.webPortal = webPortal
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

    get_to_token_prompt_command = "osascript #{@script_home}/ProdWeb.scpt \"#{specific_options.webPortal}\" \"#{password}\" \"#{token_code}\""
    puts get_to_token_prompt_command
    run_shell_command(get_to_token_prompt_command, false)
  end
end