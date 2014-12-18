require 'empty_exception'
require 'full_exception'

class DbcCircularQueue

	attr_reader :collection, :start_index, :end_index, :storage

	def initialize(size)
		@start_index = 0
		@end_index = 0
		# need to increase storage by one so that it is possible to add items when
		# the end is pointing to the final slot, otherwise, attempts to add items will
		# raise a FullException--adding one serves as a buffer
		@storage = size + 1 
		@collection = Array.new(size)  	
	end  

	def empty?
		start_index == end_index
	end

	def full?
		# need to check whether or not advancing the end will make it equal to the start
		start_index == advance(end_index)
	end

	def enqueue(elem)
		full_check
		# insert the element at the 'end', then advance the end
		@collection[end_index] = elem
		@end_index = advance(end_index)
	end

	def dequeue
		empty_check
		elem = collection[start_index]
		@start_index = advance(start_index)
		
		elem
	end

	private

	def advance(index)
		# once the index reaches the storage value, it will return 0
		(index + 1) % storage
	end

	def empty_check
		raise ::EmptyException if empty?
	end

	def full_check
		raise ::FullException if full?
	end

end
