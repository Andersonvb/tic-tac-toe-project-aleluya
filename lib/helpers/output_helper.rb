# frozen_string_literal: true

# Ouput Helper
module OutputHelper
  def self.print_message(message)
    puts message
  end

  def self.print_board(board_array)
    puts " #{board_array[0]} | #{board_array[1]} | #{board_array[2]} "
    puts '---+---+---'
    puts " #{board_array[3]} | #{board_array[4]} | #{board_array[5]} "
    puts '---+---+---'
    puts " #{board_array[6]} | #{board_array[7]} | #{board_array[8]} "
    puts
  end

  def self.print_game_title
    print_message("\nTIC TAC TOE")
    print_horizontal_line
  end

  def self.print_player_turn_message(player)
    print_message("#{player.name}'s turn. (#{player.mark}). \n\n")
  end

  def self.print_horizontal_line
    print_message("\n--------------------------------------\n\n")
  end

  def self.print_player_move(player_name, move)
    print_message("#{player_name} marked the position #{move + 1}.")
  end

  def self.print_error_message(message)
    print_horizontal_line
    puts "ERROR: #{message}\n"
    print_horizontal_line
  end

  def self.print_game_result(winner, board)
    print_board(board)

    case winner
      when :draw
        print_message("Draw!")
      when :none
        print_message('The game has finished.')
      else
        print_message("The winner is #{winner.name}! (#{winner.mark})\n\n")
    end
  end
end
