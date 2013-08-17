class Filter #:nodoc:
  def initialize
    @constraints = []
  end

  def constraint(&block)
    @constraints << block
  end

  def to_proc
    lambda { |e| @constraints.all? { |fn| fn.call(e) } }
  end
end
