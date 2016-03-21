require_relative '../models/Command'

class MvnPomChange < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'mvnpomchange'
    @command_description = 'Changes the version of the module in the current directory and all submodules to the input version.'
    @command_usage = @command_string + " <New Version>"
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, false)

    new_version = parser_components.leftover_arguments.pop
    if new_version.nil?
      puts "You MUST specify the new version!"
      puts ""
      puts "Current version is..."
      run_shell_command("mvn help:evaluate -Dexpression=project.version|grep -Ev '(^\\[|Download\\w+:)'", false)
      print_help(parser_components.basic_options_printer, nil)
    end

    command = "mvn versions:set -DnewVersion=#{new_version} -Djava.awt.headless=true -DgenerateBackupPoms=false"
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end