
class Command
  @command_string
  def initialize(command_name)
    @command_string=command_name
  end

  def get_command_string
    @command_string
  end



  def inherited other
    super if defined? super
  ensure
    ( @subclasses ||= [] ).push(other).uniq!
  end

  def subclasses
    @subclasses ||= []
    @subclasses.inject( [] ) do |list, subclass|
      list.push(subclass, *subclass.subclasses)
    end
  end
end