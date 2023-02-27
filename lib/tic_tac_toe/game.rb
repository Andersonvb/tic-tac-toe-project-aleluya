# frozen_string_literal: true

require_relative './player'
require_relative './computer_player'
require_relative './board'
require_relative '../helpers/input_helper'
require_relative '../helpers/output_helper'
require_relative './exceptions'

# Game class
class Game
  include Errors

  attr_reader :player1, :player2, :board

  def initialize
    @board = Board.new
  end

  def start_game
    OutputHelper.print_game_title

    # Pregunta al usuario qué desea hacer hasta que responda una opcion valida (Jugar o salir).
    loop do
      begin
        game_menu
        break
      rescue InvalidValueError => e
        OutputHelper.print_error_message(e)
      end
    end

    play_game
  end

  private

  # Muestra las opciones y pregunta al usuario qué desea hacer (modo de juego o salir).
  def game_menu
    user_choice = InputHelper.get_choice_from_menu

    case user_choice
      when '1' then create_players_one_player_mode
      when '2' then create_players_two_players_mode
      when '3' then exit
      else raise InvalidValueError
    end

    OutputHelper.print_horizontal_line
  end

  def create_players_one_player_mode
    player1_name = InputHelper.get_player_name(1)

    @player1 = Player.new(player1_name, 'X')
    @player2 = ComputerPlayer.new
  end

  def create_players_two_players_mode
    player1_name = InputHelper.get_player_name(1)
    player2_name = InputHelper.get_player_name(2)

    @player1 = Player.new(player1_name, 'X')
    @player2 = Player.new(player2_name, 'O')
  end

  # Itera entre el turno ambos jugadores y verifica cuando el juego ha finalizado
  def play_game
    current_player = @player1

    until @board.game_finished?
      player_turn(current_player)

      OutputHelper.print_horizontal_line

      current_player = switch_player(current_player)
    end

    # Se imprime el resultado del juego
    OutputHelper.print_game_result(get_winner, @board.board)
  end

  def player_turn(player)
    OutputHelper.print_player_turn_message(player)

    # Evaluamos si es turno de un jugador o de la maquina.
    if player.instance_of?(ComputerPlayer)
      player_choice = player.get_computer_move(@board.board)
    else
      OutputHelper.print_board(@board.board)

      player_choice = InputHelper.get_user_option
    end

    # Evaluamos si el usuario desea salir, reiniciar o marcar una casilla
    case player_choice
      when 'exit' then exit
      when 'restart' then restart_game
      else mark_space(player_choice, player)
    end
  end

  def switch_player(current_player)
    current_player == @player1 ? @player2 : @player1
  end

  def mark_space(space, player)
    begin
      @board.mark_space(space, player.mark)

      OutputHelper.print_player_move(player.name, space)
    rescue StandardError => e
      OutputHelper.print_error_message(e)

      player_turn(player)
    end
  end

  def get_winner
    case @board.winner
      when :x then @player1
      when :o then @player2
      else @board.winner
    end
  end

  def restart_game
    @board = Board.new
    start_game
  end
end
