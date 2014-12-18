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
		@collection[collection.count] = elem
	end

	def dequeue
		raise ::EmptyException if empty?
		# again, doing things very literally
		elem = collection[0]
		@collection = collection[1..-1]
		elem
	end

end
