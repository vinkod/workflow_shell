require_relative '../models/Command'
require_relative '../misc/UploadJars'

class MavenGo < Command
  @command_string
  @command_description
  @command_usage = @command_string

  def initialize
    @command_string = 'mvngo'
    @command_description = "Builds a Maven project with various options."
    @command_usage = @command_string + " <options>"
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, false)

    # Parse any specific options and print help if necessary.
    specific_options = OpenStruct.new
    specific_options.quiet = false
    specific_options.skip_tests = false
    specific_options_parser = OptionParser.new do |opts|
      opts.banner = ""
      opts.separator  "Specific options: "

      opts.on("-q", "--quiet", "Suppress most output.") do
        specific_options.quiet = true
      end

      opts.on("-n", "--noTest", "Skip unit and integration tests.") do
        specific_options.skip_tests = true
      end

      opts.on("-u", "--upload", "Upload the JAR(s) when done.") do
        specific_options.upload = true
      end

      opts.on("-f", "--fast", "Build with multiple threads.") do
        specific_options.fast = true
      end

      opts.on("-s", "--site", "Build with a site report.") do
        specific_options.site = true
      end

      if parser_components.basic_options.help
        puts parser_components.basic_options_printer
        puts opts
        exit
      end

      opts.separator ""
      opts.separator "Some of these options may not work well together, specifically building with multiple threads."
    end

    specific_options_parser.parse!(parser_components.leftover_arguments)

    # unless parser_components.leftover_arguments.empty?
    #   puts "Unknown arguments left over: " + parser_components.leftover_arguments.to_s
    #   puts ""
    #   print_help(parser_components.basic_options_printer, specific_options_parser)
    # end

    # Base command
    command = "mvn -U clean install"

    if specific_options.site
      command += " site"
    end

    # Optional multiple threads
    if specific_options.fast
        command += " -T 3C"
    end

    if specific_options.quiet
      command += " --quiet"
    end

    if specific_options.skip_tests
      command += " -Dmaven.test.skip=true -DskipITs"
    end

    # Make sure it doesn't pop up those irritating Java GUI processes that steal window focus
    command += " -Djava.awt.headless=true"

    parser_components.leftover_arguments.each { |arg| command += " " + arg }

    # Run it
    run_shell_command(command, parser_components.basic_options.verbose)

    # Upload the JARs
    if specific_options.upload
      UploadJars.new.run_command([])
    end
  end

end