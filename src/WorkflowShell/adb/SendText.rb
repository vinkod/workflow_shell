require_relative '../models/Command'

class SendText < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'ast'
    @command_description = 'Sends text with ADB.'
    @command_usage = @command_string
  end

  def run_command(arguments)
    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, false)
    if parser_components.nil?
      puts "You MUST specify the text to send!"
      puts ""
      print_help(parser_components.basic_options_printer, nil)
    end

    text_to_send = parser_components.leftover_arguments.pop
    text_to_send = text_to_send.gsub('(','\(')
    text_to_send = text_to_send.gsub(')','\)')
    text_to_send = text_to_send.gsub('<','\<')
    text_to_send = text_to_send.gsub('>','\>')
    text_to_send = text_to_send.gsub('|','\|')
    text_to_send = text_to_send.gsub(';','\;')
    text_to_send = text_to_send.gsub('&','\&')
    text_to_send = text_to_send.gsub('*','\*')
    text_to_send = text_to_send.gsub('~','\~')
    text_to_send = text_to_send.gsub('\"','\\\"')
    text_to_send = text_to_send.gsub('\'','\\\'')
    text_to_send = text_to_send.gsub(' ','%s')

    command = "adb shell input text \"#{text_to_send}\""
    puts "Command to send: " + command
    run_shell_command(command, parser_components.basic_options.verbose)
  end
end