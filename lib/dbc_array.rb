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
		pos = at
  	if at != 0
  		pos = collection.index(at) 
  	end
  	@collection = collection[0...pos] + [elem] + collection[pos..-1]
  end

  def at(pos, put: nil)
  	raise ::OutOfBoundException unless (0..collection.length).include?(pos.abs) #using collection.length so that elements can be inserted at the end
  	collection[pos] = put if put
  	collection[pos]
  end

  def append(elem)
  	@collection << elem
  	self
  end

  def remove_at(pos)
  	@collection = collection[0...pos] + collection[(pos + 1)..-1]
  end

end
