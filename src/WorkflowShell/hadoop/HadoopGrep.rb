require_relative '../models/Command'

class HadoopGrep < Command
  @command_string
  @command_description
  @command_usage = @command_string

  def initialize
    @command_string = 'hgrep'
    @command_description = "Greps through hadoop logs downloaded with ''" + HadoopDownloadLog.new.get_command_string + "''."
    @command_usage = @command_string + " <options>"
  end

  def run_command(arguments)
    original_arguments = arguments.dup
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, false)

    # Parse any specific options and print help if necessary.
    specific_options = OpenStruct.new
    specific_options_parser = OptionParser.new do |opts|
      opts.banner = ""
      opts.separator  "Specific options: "
      opts.on("-t", "--term SEARCH_TERM", String, "The term to find in the logs.") do |term|
        specific_options.search_term = term
      end

      opts.on("-f", "--outputFile FILE_NAME", "The file to which the grep output should be routed.") do |file|
        specific_options.file_name = file
      end

      if parser_components.basic_options.help
        puts parser_components.basic_options_printer
        puts opts
        exit
      end

      opts.separator ""
      opts.separator "Example: wsh hgrep --term \"Normalization Failed\" --outputFile normfail.txt"
    end

    specific_options_parser.parse!(parser_components.leftover_arguments)

    if specific_options.search_term.nil? || specific_options.file_name.nil?
      puts "You MUST specify both the search term and an output file name."
      puts ""
      print_help(parser_components.basic_options_printer, specific_options_parser)
    end

    unless parser_components.leftover_arguments.empty?
      puts "Unknown arguments left over: "+parser_components.leftover_arguments.to_s
      puts ""
      print_help(parser_components.basic_options_printer, specific_options_parser)
    end

    command = "grep  -A 5 -R --include=\"*all*\" \"#{specific_options.search_term}\" . > \"#{specific_options.file_name}\""
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end