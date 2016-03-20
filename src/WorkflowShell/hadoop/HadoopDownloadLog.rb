require_relative '../models/Command'
require_relative '../hadoop/HadoopDownloadLog'

class HadoopDownloadLog < Command
  @command_string
  @command_description
  @command_usage = @command_string

  def initialize
    @command_string = 'hdl'
    @command_description = "Downloads hadoop logs."
    @command_usage = @command_string + " <Job URL> \r\n" +
        "Example: hdl \"http://pophdevhadoopmstr01.northamerica.cerner.net:50030/jobdetails.jsp?jobid=job_201507281713_19288\""
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, false, true)

    job_url = parser_components.leftover_arguments.pop
    if job_url.to_s == ""
      puts "You MUST specify the job URL!"
      puts ""
      print_help(parser_components.basic_options_printer, nil)
    end

    job_id = job_url.to_s.split("jobid=").last

    command = "wget --recursive -H --accept-regex \"#{job_id}\" \"#{job_url}\""
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end