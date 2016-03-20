require_relative '../models/Command'

class UploadJars < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'uploadjars'
    @command_description = "Uploads console JARs to various util nodes. This command must be run in the project's root or in one of the console modules' folders)"
    @command_usage = @command_string
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, true)


    # Remove those "original" JARs.
    run_shell_command("rm *-console/target/*original*.jar", parser_components.basic_options.verbose)
    run_shell_command("rm target/*original*.jar", parser_components.basic_options.verbose)

    # Upload the real console JARs.
    run_shell_command("scp *-console/target/*console*SNAPSHOT.jar \"$USER@pophdevvm219:~/\"", parser_components.basic_options.verbose)
    run_shell_command("scp target/*console*SNAPSHOT.jar \"$USER@pophdevvm219:~/\"", parser_components.basic_options.verbose)
    run_shell_command("scp *-console/target/*console*SNAPSHOT.jar \"$USER@pophdevutil30:~/\"", parser_components.basic_options.verbose)
    run_shell_command("scp target/*console*SNAPSHOT.jar \"$USER@pophdevutil30:~/\"", parser_components.basic_options.verbose)
  end
end