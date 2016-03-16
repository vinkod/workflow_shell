require_relative '../models/Command'

class GitPushForceOrigin < Command
  @command_string='gpfo'
  def initialize
    super(@command_string)
  end

  def stuff
    puts("I guess it worked.")
  end
end