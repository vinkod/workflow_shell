require_relative '../models/Command'

class BuildFreshCandidateStream < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'jsbfcs'
    @command_description = 'Clones candidate stream, changes to a specified directory, runs "npm install" and then "grunt build".'
    @command_usage = @command_string + " <Module Path> <Branch Name>"
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, false)

    branch_name = parser_components.leftover_arguments.pop
    if branch_name.to_s == ""
      puts "You really should have specified the branch name... Since you didn't, we will use whatever the repo's default is."
      puts ''
      print_help(parser_components.basic_options_printer, nil)
    end
    puts "Branch Name: #{branch_name}"

    module_path = parser_components.leftover_arguments.pop
    if module_path.to_s == ""
      puts "You MUST specify the module to CD to! Specify '.' if you must.\n"
    #   puts ''
      print_help(parser_components.basic_options_printer, nil)
    end
    puts "Module Path: #{module_path}"

    puts ''

    if File.directory?("candidatestream")
        puts 'The candidatestream folder already exists, please delete it.'
        exit (-1)
    end

    clone = "git clone git@github.com:cbdr/candidatestream.git"
    run_shell_command(clone, parser_components.basic_options.verbose)

    full_path = "candidatestream/#{module_path}"
    cd_to_module = "cd \"#{full_path}\""

    git_checkout = "#{cd_to_module} && git checkout \"#{branch_name}\""
    run_shell_command(git_checkout, parser_components.basic_options.verbose)

    npm_install = "#{cd_to_module} && npm install"
    run_shell_command(npm_install, parser_components.basic_options.verbose)

    grunt_build = "#{cd_to_module} && grunt build"
    run_shell_command(grunt_build, parser_components.basic_options.verbose)

  end
end