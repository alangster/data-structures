require 'empty_exception'
require 'full_exception'

class DbcCircularQueue

	attr_reader :collection, :front, :rear

	def initialize(size)
		@front = 0
		@rear = size 
		@collection = []  	
	end  

	def empty?
		collection.size == 0
	end

	def full?
		front == rear
	end

	def enqueue(elem)
		full_check
		@collection << elem
		@front += 1
	end

	def dequeue
		empty_check
		elem = collection[0]
		@collection = collection[1..-1]
		@front += 1
		@rear += 1
		elem
	end

	private

	def empty_check
		raise ::EmptyException if empty?
	end

	def full_check
		raise ::FullException if full?
	end

end
