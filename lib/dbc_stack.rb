require 'empty_exception'

class DbcStack

	attr_reader :collection

  def initialize
 		@collection = []
  end

  def empty?
  	@collection.count == 0
  end

  def push(elem)
  	@collection << elem
  end

  def pop
  	empty_check
  	elem = collection[-1]
  	@collection = collection[0..-2]
  	elem
  end

  def peek
  	empty_check
  	collection[0]
  end

  private

  def empty_check
  	raise ::EmptyException if empty?
  end

end
