require 'empty_exception'

class DbcQueue

	attr_reader :collection

	def initialize
		@collection = []
	end

	def empty?
		# although i could just use #empty? on the collection array,
		# I want to implement everything very literally
		collection.count == 0
	end

	def enqueue(elem)
		@collection << elem
	end

	def dequeue
		raise ::EmptyException if empty?
		@collection.shift
	end

end
