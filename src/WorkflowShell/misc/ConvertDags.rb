require_relative '../models/Command'

class ConvertDags < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'dags'
    @command_description = 'Converts all *.dot files to PNG files.'
    @command_usage = @command_string
  end

  DOT_FILE_EXTENSION = '.dot'
  PNG_FILE_EXTENSION = '.png'

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, true)

    Dir.foreach('.') do |file|
      next if file == '.' or file == '..'
      file_name=file.to_s

      if file_name.end_with? (DOT_FILE_EXTENSION)
        png_name = file_name.chomp(DOT_FILE_EXTENSION).concat(PNG_FILE_EXTENSION)
        command = "dot -Tpng \"#{file_name}\" > \"#{png_name}\""
        run_shell_command(command, parser_components.basic_options.verbose)
      end
    end
  end
end