require_relative '../models/Command'
#puts "gpfo: "
class GitPushForceOrigin < Command
  @command_string
  @command_description

  def initialize
    @command_string='gpfo'
    @command_description='Force pushes the current branch into a remote branch of the same name.'
  end

  def run_command(arguments)
    parser_components = parse_options(arguments)
    parser_components.basic_options

    # parser_components.options_parser
    parser_components.leftover_arguments

    options = OpenStruct.new
    options.verbose = false

    specific_options_parser = OptionParser.new do |opts|
      opts.separator ""
      opts.separator "There are no specific options for this command."

      if parser_components.basic_options.help
        puts opts
        exit
      end
    end

    puts "DO STUFF"
  end
end