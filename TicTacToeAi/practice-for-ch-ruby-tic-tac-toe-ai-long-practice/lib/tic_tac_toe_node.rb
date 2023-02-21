require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    # return true if board.winner != evaluator
    

    # self.children.each do |child|
    #   child.losing_node?(evaluator)
    # end
    if board.over?
      return board.winner != evaluator && board.winner != nil
    end

    if evaluator == next_mover_mark
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end

  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    board.open_positions.each do |pos|
      new_board = board.dup

      new_board[pos] = next_mover_mark
      next_mover_mark = self.next_mover_mark == :x ? :o : :x
      
      node = TicTacToeNode.new(new_board,next_mover_mark,pos)
      children << node
    end
    children
  end
end