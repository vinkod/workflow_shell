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

  # Main body of commands. If this instance of this method is reached, something went wrong.
  def run_command(arguments)
    raise "Specified command did not implement 'run_command' method."
  end

  def parse_options(arguments)
    options = OpenStruct.new
    options.verbose = false
    options.help = false

    basic_options_parser = OptionParser.new do |opts|
      opts.banner = "Usage: " + @command_string
      opts.separator ""
      opts.separator "Basic options:"

      # Boolean switch.
      opts.on("-v", "--verbose", "Run verbosely") do
        options.verbose = true
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
end