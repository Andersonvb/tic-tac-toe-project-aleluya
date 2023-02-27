# frozen_string_literal: true

require_relative './exceptions'

# Board Class
class Board
  include Errors

  attr_accessor :winner
  attr_reader :board

  WINNING_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # Filas
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # Columnas
    [0, 4, 8], [2, 4, 6] # Diagonales
  ].freeze

  def initialize
    @board = Array.new(9, ' ')
    @winner = :none # :none, :o, :x, :draw
  end

  def mark_space(space, mark)
    raise InvalidValueError if invalid_value?(space)

    raise NotAvailableSpaceError unless space_available?(space)

    @board[space] = mark
  end

  def game_finished?
    win? || draw?
  end

  private

  def space_available?(space)
    @board[space] == ' '
  end

  def invalid_value?(value)
    !(0..8).to_a.include?(value)
  end

  def win?
    WINNING_COMBINATIONS.each do |combination|
      possible_win = [
        @board[combination[0]],
        @board[combination[1]],
        @board[combination[2]]
      ]

      if possible_win.uniq.size == 1 && !possible_win.include?(' ')
        @winner = possible_win[0].downcase.to_sym
        return true
      end
    end
    false
  end

  def draw?
    if full? && !win?
      @winner = :draw
      true
    else
      false
    end
  end

  def full?
    @board.all? { |mark| mark != ' ' }
  end
end
