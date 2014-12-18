class DBCBinaryTree

	attr_reader :root_node

	def initialize
		@root_node
	end

	def empty?
		root_node.nil?
	end

	def to_s
		return "[]" if empty?
		root_node.to_s
	end

	def size
		return 0 if empty?
		root_node.child_count
	end

	def depth
		return 0 if empty?
		root_node.depth
	end

	def insert(value)
		if empty?
			@root_node = BinaryTreeNode.new(value)
		else
			root_node.insert(value)
		end
	end

	def find(value)
		root_node.find(value)
	end

	def preorder(&block)
		return "" if empty?
		root_node.preorder(&block)
	end

	def postorder(&block)
		return "" if empty?
		root_node.postorder(&block)
	end

	def inorder(&block)
		return "" if empty?
		root_node.inorder(&block)
	end

	def map(&block)
		return [] if empty?
		root_node.map(&block)
	end
  
end


class NilTreeNode

	def to_s
		"-"
	end

	def child_count
		0
	end

	def depth
		0
	end

	def find(value)
		false
	end

	def insert(value)
		# return a new BinaryTreeNode to take the spot of the current NilTreeNode
		BinaryTreeNode.new(value)
	end

	def preorder(&block)
		# return nil to stop the process
	end

	def postorder(&block)
	end

	def inorder(&block)
	end

	def map(&block)
		NilTreeNode.new
	end
  
end


class BinaryTreeNode

	attr_reader :value, :lesser_child, :greater_child

	def initialize(value, greater_child = NilTreeNode.new, lesser_child = NilTreeNode.new)
	  @value = value
	  @greater_child = greater_child
	  @lesser_child = lesser_child
  end 

  def to_s
  	"[#{lesser_child.to_s} #{value} #{greater_child.to_s}]" 	
  end 

  def child_count
  	count = 1
  	# increment the count for each child to get the total number of children
  	children.each do |child|
  		count += child.child_count
  	end
  	count
  end

  def depth
  	# find and return the greatest of the depths
  	1 + children.map(&:depth).max
  end

  def insert(new_value)
  	if new_value > value
  		# set greater_child equal to result of calling insert on existing greater child
  		@greater_child = greater_child.insert(new_value)
  	elsif new_value < value
  		@lesser_child = lesser_child.insert(new_value)
  	end
  	# return self in order to preserve the tree
  	self
  end

  def find(search_value)
  	# return true if found the value
  	return true if value == search_value
  	# if search value is greater than greater_child, call #find on greater_child
  	return greater_child.find(search_value) if search_value > value
  	# otherwise, call #find on the lesser_child
  	lesser_child.find(search_value)
  end

  def preorder(&block)
  	# call block with node's value, then with lesser, then with greater
  	yield(value) 
  	lesser_child.preorder(&block) 
  	greater_child.preorder(&block)
  end

  def postorder(&block)
  	lesser_child.postorder(&block)
  	greater_child.postorder(&block)
  	yield(value)
  end

  def inorder(&block)
  	#needs to be symmetric
  	lesser_child.inorder(&block)
  	yield(value)
  	greater_child.inorder(&block)
  end

  def map(&block)
  	# need to return a new binary tree, which required me to move the creation of child nodes
  	# into BinaryTreeNode's intialize method
  	BinaryTreeNode.new(yield(value), greater_child.map(&block), lesser_child.map(&block))
  end

  private

  def children
  	[lesser_child, greater_child]
  end

end
