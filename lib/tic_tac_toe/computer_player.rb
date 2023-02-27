# frozen_string_literal: true

require_relative './board'
require_relative './player'

# Computer class.
class ComputerPlayer < Player

  def initialize
    super('Computer', 'O')
  end

  def get_computer_move(board)
    # Comprueba si hay una posición ganadora.
    winning_move = find_winning_move(board, @mark)
    return winning_move if winning_move

    # Busca un movimiento para bloquear al oponente.
    opponent_mark = 'X'
    blocking_move = find_winning_move(board, opponent_mark)
    return blocking_move if blocking_move

    # Elije una posición disponible al azar.
    available_positions = board.each_index.select { |i| board[i] == ' ' }
    available_positions.sample
  end

  private

  def find_winning_move(board, mark)
    Board::WINNING_COMBINATIONS.each do |combination|
      if combination.count { |index| board[index] == mark } == 2 &&
         combination.count { |index| board[index] == ' ' } == 1
        return combination.find { |index| board[index] == ' ' }
      end
    end
    nil
  end
end
