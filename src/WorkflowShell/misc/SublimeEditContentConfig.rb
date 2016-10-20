require_relative '../models/Command'

class SublimeEditContentConfig < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'sublcontent'
    @command_description = 'Opens, in Sublime, all content record config files in deployment repo.'
    @command_usage = @command_string
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, true)

    command = "subl " +
        "config/dev/contentLoad/config.yaml " +
        "config/dev_aws/contentLoad/config.yaml " +
        "config/dev_cdh5/contentLoad/config.yaml " +
        "config/mapping/contentLoad/config.yaml " +
        "config/mapping_uk/contentLoad/config.yaml " +
        "config/prod/contentLoad/config.yaml " +
        "config/prod_cdh5/contentLoad/config.yaml " +
        "config/prod_uk/contentLoad/config.yaml " +
        "config/staging/contentLoad/config.yaml " +
        "config/staging_cdh5/contentLoad/config.yaml " +
        "config/wip/contentLoad/config.yaml " +
        "config/wip_cdh5/contentLoad/config.yaml "

    run_shell_command(command, parser_components.basic_options.verbose)
  end
end