# These will allow us to parse options nicely
require 'optparse'
require 'ostruct'

class Command

  # These are intended to be superclass methods. Hopefully each subclass will define these variables.
  def get_command_string
    @command_string
  end
  def get_command_description
    @command_description
  end
  def get_command_usage
    @command_usage
  end

  # Main body of commands. If this instance of this method is reached, something went wrong.
  def run_command(arguments)
    raise "Specified command did not implement 'run_command' method."
  end

  def parse_options(arguments)
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
    # It will remove all options that it interacts with.
    basic_options_parser.parse!(arguments)

    # OpenStruct allows you to basically create a POJO-esque map-type object on the fly.
    parser_components = OpenStruct.new
    parser_components.basic_options = options
    parser_components.basic_options_printer = @basic_options_printer
    parser_components.leftover_arguments = arguments
    parser_components
  end

  # This method will return all subclasses of this class
  # https://stackoverflow.com/questions/3676274/how-to-get-all-class-names-in-a-namespace-in-ruby
  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
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

  def run_shell_command (command, verbose)
    # Print the command, if desired
    if verbose
      puts "Running: " + command
    end

    # Run the command
    command_result = suppress_warnings { `#{command}` }

    # Print the result
    if verbose && !command_result.nil? && !command_result.empty?
      puts command_result
      puts ""
    end

    # return
    command_result
  end
end