class MonitorConnection < Command
  @command_string
  @command_description
  @command_usage

  def initialize
    @command_string = 'tpmc'
    @command_description = "Monitors this computer's internet connection and resets the tplink plug if necessary."
    @command_usage = @command_string
  end

def run_command(arguments)
    # This will hopefully check for the presence of some gems we need, and install them if they aren't present.
    begin
      gem "win32-security"
    rescue LoadError
      puts("Gem 'win32-security' not installed, installing...")
      system("gem install win32-security")
      Gem.clear_paths
    end
    begin
      gem "net-ping"
    rescue LoadError
      puts("Gem 'net-ping' not installed, installing...")
      system("gem install net-ping")
      Gem.clear_paths
    end

    require 'win32/security'
    require 'net/ping'
    require_relative '../models/Command'

    # Ask the Command class to parse the basic options like help and verbosity
    parser_components = parse_options(arguments, true)

    # Begin the command
    current_directory = File.expand_path(File.dirname(__FILE__))
    turn_off = File.expand_path(File.dirname(__FILE__)) + '/lib/turn_off.py'
    turn_on = File.expand_path(File.dirname(__FILE__)) + '/lib/turn_on.py'
    while true do
      ping_successful = true
      while ping_successful do
        puts("Pinging 4.2.2.2...")
        thing = Net::Ping::External.new('4.2.2.2');
        ping_successful = thing.ping?
        puts("Ping successful. Sleeping for 15 seconds...")
        sleep(15)
      end

      puts('Ping FAILED! Turning plug off...')
      Process.spawn("python #{turn_off}")
      puts('Sleeping for 15 seconds...')
      sleep(15)

      puts('Turning plug on...')
      Process.spawn("python #{turn_on}")
      puts('Sleeping for 60 seconds...')
      sleep(60)
    end
  end
end
