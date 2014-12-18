require 'empty_exception'

class DbcArray

	attr_reader :collection

  def initialize
  	@collection = []
  end

  def empty?
  	collection.count == 0
  end

  def size
  	collection.count
  end

  def insert(elem, at: 0)
  	@collection = collection[0...at] + [elem] + collection[at..-1]
  end

  def at(pos, put: nil)
    #using collection.length so that elements can be inserted at the end
    raise ::OutOfBoundException unless (0..collection.length).include?(pos.abs) 
    return collection[pos] if put.nil?
  	collection[pos] = put
  end

  def append(elem)
  	@collection[collection.length] = elem
  	self
  end

  def remove_at(pos)
  	@collection = collection[0...pos] + collection[(pos + 1)..-1]
  end

end
