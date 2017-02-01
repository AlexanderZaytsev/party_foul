class PartyFoul::ExceptionDump
  attr_accessor :data

  def initialize(exception)
    @data = {
      'class' => exception.class,
      'message' => exception.message,
      'to_s' => exception.to_s,
      'backtrace' => exception.backtrace
    }
  end

  def method_missing(method_name)
    @data[method_name.to_s]
  end

  def class
    @data['class']
  end

  def to_s
    @data['to_s']
  end
end