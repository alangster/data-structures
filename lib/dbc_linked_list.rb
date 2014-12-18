class DBCLinkedList

	attr_reader :head

  def initialize
  	# no nodes, so set head to nil
  	@head = nil
  end

  def empty?
  	head.nil?
  end

  def size
  	return 0 if empty?
  	head.size
  end

  def to_a
  	return [] if empty?
  	head.to_a
  end

  def append(data)
  	if empty?
  		@head = ListNode.new(data)
  	else
  		head.append(data)
  	end
  end

  def find(data = nil, &block)
  	return nil if empty?
  	if data.nil?
  		head.find_by_predicate(&block)
  	else
	  	head.find(data)
	  end
  end

  def prepend(data)
  	# make the old head the new second node
  	@head = ListNode.new(data, @head)
  end

  def insert_after(data, node)
  	head.insert_after(data, node)
  end

  def delete(node)
  	return nil if empty?
  	if head == node
  		@head = head.next_node
  	else
	  	head.delete(node)
	  end
  end

  def map(&block)
  	return nil if empty?
  	head.map(&block)
  end

  def reduce(memo = nil, &block)
  	return nil if empty?
  	head.reduce(memo, &block)
  end

  def insert_in_order(data)
  	if head.nil? || head.data > data
  		prepend(data)
  	else
  		head.insert_in_order(data)
  	end
  end

  def map_with(other_list, &block)
  	# ensure that what is passed is a node, rather than a list
  	head.map_with(other_list.head, &block)
  end
  
end


#--------------------------------------------------------------------------------


class ListNode

	attr_reader :data, :next_node

  def initialize(data, next_node = nil)
  	@data = data
  	@next_node = next_node
  end

  def append(data)
  	# if there is no next_node, create the new node there
  	# otherwise, find the end of the linked list
  	if next_node.nil?
  		@next_node = ListNode.new(data)
  	else
  		next_node.append(data)
  	end
  end

  def size
  	return 1 if next_node.nil?
  	1 + next_node.size
  end

  def to_a
  	return [data] if @next_node.nil?
  	[data] + next_node.to_a
  end

  def find(search_data)
  	if data == search_data
  		self
  	elsif next_node
  		next_node.find(search_data)
		end
  	# simply return nil if the searched-for node does not exist
  end

  def insert_after(new_data, node)
  	if self == node
  		@next_node = ListNode.new(new_data, next_node)
  	elsif next_node
  		next_node.insert_after(new_data, node)
  	end
  	# simply return nil if the searched-for node does not exist
  end

  def delete(node)
  	if next_node == node
  		@next_node = node.next_node
  	elsif next_node
  		next_node.delete(node)
  	end
  	# simply return nil if the searched-for node does not exist
  end

  def map(&block)
  	result = [yield(self.data)]
  	if next_node.nil?
  		result
  	else
  		result + next_node.map(&block)
  	end
  end

  def reduce(memo, &block)
  	# re-assign the memo to the value of evaluating the block
  	memo = yield(memo, data) 
  	if next_node
  		next_node.reduce(memo, &block)
  	else
  		memo
  	end
  end

  def insert_in_order(new_data)
  	if next_node.nil?
  		# insert data if at end of list
  		@next_node = ListNode.new(new_data)
  	elsif next_node.data > new_data 
  		# if the next node's data is greater than the new data,
  		# insert the new data before it
  		@next_node = ListNode.new(new_data, next_node)
  	else 
  		# if next node's data is not greater than the new data,
  		# attemt the insertion with the next node
  		@next_node.insert_in_order(new_data)
  	end
  end

  def find_by_predicate(&block)
  	if yield(self.data)
  		# return self if self satisfies the block
  		self
  	elsif next_node
  		next_node.find_by_predicate(&block)
  	else
  		nil
  	end
  end

  def map_with(node, &block)
  	result = [yield(self.data, node.data)]
  	if next_node
  		result + next_node.map_with(node.next_node, &block)
  	else
  		result
  	end
  end
  
end
