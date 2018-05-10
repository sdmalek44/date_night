require './lib/node.rb'

class BinarySearchTree

  attr_accessor :root_node,
                :total_nodes,
                :leaves

  def initialize
    @total_nodes = 0
    @leaf_depths = []
  end

  def insert(new_score, new_movie, depth = 0)
    @total_nodes += 1
    if @root_node == nil
      @root_node = Node.new(new_score, new_movie)
      depth
    else
      new_node = @root_node.pass_down(new_score, new_movie, depth)
      new_node.depth
    end
  end

  def include?(score, node = @root_node)
    if score == node.score
      true
    elsif score < node.score
      if node.left_node == nil
        false
      else
        include?(score, node.left_node)
      end
    elsif score > node.score
      if node.right_node == nil
        false
      else
        include?(score, node.right_node)
      end
    end
  end

  def depth_of(score, node = @root_node)
    if score == node.score
      node.depth
    elsif score < node.score
      if node.left_node == nil
        nil
      else
        depth_of(score, node.left_node)
      end
    elsif score > node.score
      if node.right_node == nil
        nil
      else
        depth_of(score, node.right_node)
      end
    end
  end

  def max(node = @root_node)
    if node.right_node == nil
      { node.movie => node.score}
    else
      max(node.right_node)
    end
  end

  def min(node = @root_node)
    if node.left_node == nil
      { node.movie => node.score}
    else
      min(node.left_node)
    end
  end

  def sort(node = @root_node, array = [])
    if node.left_node == nil
      array << {node.movie => node.score}
    else
      sort(node.left_node, array)
      array << {node.movie => node.score}
    end
    if node.right_node != nil
      sort(node.right_node, array)
    end
    array
  end

  def load(filename)
    file = File.open(filename, 'r')
    score_movie_array = file.readlines
    score_movie_array.map! { |score_movie| score_movie.delete("\n").split(", ") }
    score_movie_array.each do |score_movie|
      if @total_nodes == 0
        insert((score_movie[0].to_i), score_movie[1])
      else
        if !(include?(score_movie[0].to_i))
          insert((score_movie[0].to_i), score_movie[1])
        end
      end
    end
  end

  def health(depth, node = @root_node, total_health = [])
    if node == nil
      nil
    elsif depth == node.depth
      children = child_count(node)
      total_health << [node.score, children, ((children.to_f)/@total_nodes*100).to_i]
    else
      health(depth, node.left_node, total_health)
      health(depth, node.right_node, total_health)
    end
    total_health
  end

  def child_count(node = @root_node)
    if node == nil
      0
    else
      left_child = child_count(node.left_node)
      right_child = child_count(node.right_node)
      left_child + right_child + 1
    end
  end

  def leaves(node = @root_node)
    if node == nil
      0
    elsif node.left_node == nil && node.right_node == nil
      @leaf_depths << node.depth
      1
    else
      left_leaves = leaves(node.left_node)
      right_leaves = leaves(node.right_node)
      left_leaves + right_leaves
    end
  end

  def height
    @leaf_depths = []
    leaves
    @leaf_depths.max
  end

end
