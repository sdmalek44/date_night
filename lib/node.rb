
class Node

  attr_accessor :depth,
                :score,
                :left_node,
                :right_node,
                :movie

  def initialize(score, movie_name, depth = 0)
    @score = score
    @depth = depth
    @movie = movie_name
  end

  def pass_down(new_score, new_movie, depth = 0)
    depth += 1
    case new_score <=> @score
    when -1
      if @left_node == nil
        @left_node = Node.new(new_score, new_movie, depth)
      else
        @left_node.pass_down(new_score, new_movie, depth)
      end
    when 1
      if @right_node == nil
        @right_node = Node.new(new_score, new_movie, depth)
      else
        @right_node.pass_down(new_score, new_movie, depth)
      end
    end
  end
end
