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
    parser_components.leftover_arguments

    specific_options_parser = OptionParser.new do |opts|
      opts.banner = ""
      opts.separator "There are no specific options for this command."

      if parser_components.basic_options.help
        puts parser_components.basic_options_printer
        puts opts
        exit
      end
    end

    specific_options_parser.parse!(arguments)

    get_branch_command = "git rev-parse --abbrev-ref HEAD"
    branch_name = run_shell_command(get_branch_command, parser_components.basic_options.verbose)

    push_command = "git push -f origin #{branch_name}"
    push_result = run_shell_command(push_command, parser_components.basic_options.verbose)
  end
end