# These will allow us to parse options nicely
require 'optparse'
require 'ostruct'

class Command

  # These are intended to be superclass methods. Hopefully each subclass will define these variables.
  def get_command_string
    return @command_string
  end
  def get_command_description
    return @command_description
  end
  def get_command_usage
    return @command_usage
  end

  # Main body of commands. If this instance of this method is reached, something went wrong.
  def run_command(arguments)
    raise "Specified command did not implement 'run_command' method."
  end

  def parse_options(arguments, is_basic_command)
    arguments_backup = arguments.dup
    options = OpenStruct.new
    options.verbose = true
    options.help = false

    basic_options_parser = OptionParser.new do |opts|
      opts.banner = "Usage: " + get_command_usage
      opts.separator ""
      opts.separator "Basic options:"

      # Boolean switch.
      opts.on("-v", "--verbose", "Do NOT run verbosely") do
        options.verbose = false
      end

      opts.on_tail("-h", "--help", "Show this message") do
        options.help = true
      end

      @basic_options_printer = opts
    end

    # This will call the parser and make it put all basic options into basic_options
    # It will remove all options that it interacts with. If it finds an option it
    # doesn't understand, it will store it and those will be sent in the result.
    leftover_collector = Array.new
    begin
      # Attempt to parse everything
      basic_options_parser.parse!(arguments)
    rescue OptionParser::InvalidOption => e
      # Put the option contained in the error into the leftover collector
      leftover_collector << e.args
      # Check to see if the next thing is not an option, and put that in the collector too
      if !arguments.first.nil? && !arguments.first.start_with?('-')
        leftover_collector << arguments.shift
      end
      retry
    end
    leftover_arguments  = arguments_backup & ( arguments | leftover_collector.flatten )

    if is_basic_command && options.help
      print_help(@basic_options_printer, nil)
      exit (-1)
    end
    if is_basic_command && !leftover_arguments.empty?
      puts "Unknown arguments left over: " + leftover_arguments.to_s
      puts ""
      print_help(@basic_options_printer, nil)
    end

    # OpenStruct allows you to basically create a POJO-esque map-type object on the fly.
    parser_components = OpenStruct.new
    parser_components.basic_options = options
    parser_components.basic_options_printer = @basic_options_printer
    parser_components.leftover_arguments = leftover_arguments

    return parser_components
  end

  # This method will return all subclasses of this class
  # https://stackoverflow.com/questions/3676274/how-to-get-all-class-names-in-a-namespace-in-ruby
  def self.descendants
    return ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  # When calling system commands, I get a warning that my path has a writable directory in it.
  # I have ALL SORTS of stuff in my path and they are nice and convenient, so I don't want to clean them up.
  # For now, just suppress those warnings.
  # TODO: This is probably not good.
  # https://stackoverflow.com/questions/5708806/erroneous-insecure-world-writable-dir-foo-in-path-when-running-ruby-script
  def suppress_warnings
    original_verbosity = $VERBOSE
    $VERBOSE = nil
    result = yield
    $VERBOSE = original_verbosity
    return result
  end

  def run_shell_command_with_output (command, verbose)
    # Print the command, if desired
    if verbose
      puts "Running: " + command
    end

    # Run the command
    # This line doesn't show color in the terminal, it just sort of does a "puts" of the output. But, at least we can know what that output was.
    command_result = suppress_warnings { `#{command}` }

    if verbose
      puts "Result was: " + command_result
    end
    puts ""

    return command_result
  end

  def run_shell_command (command, verbose)
    # Print the command, if desired
    if verbose
      puts "Running: " + command
    end

    # Run the command
    # This line doesn't return the output, but at least we get terminal colors. The only result is pass/fail
    command_result = suppress_warnings { system(command) }
    puts ""

    return command_result
  end

  def print_help (basic_options, specific_options)
    puts basic_options
    puts specific_options
    exit(-1)
  end

  def print_interactivity_warning
    puts("IMPORTANT NOTE: Do NOT interfere with the keyboard and/or mouse while this script is running. " +
             "Doing so will almost certainly cause this script to fail. Failure may be spectacular " +
             "(e.g. sending your production password or pin to someone over Lync) but it may not be immediately obvious " +
             "(e.g. repeatedly entering the wrong value into username or password and locking you out of production).")
  end
end