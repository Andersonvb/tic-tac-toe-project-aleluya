# frozen_string_literal: true

require_relative './output_helper'

# Input Helper
module InputHelper
  def self.get_input(prompt)
    print prompt
    gets.chomp
  end

  def self.get_user_option
    message = "Commands:\n" \
              " - exit      Exit game.\n" \
              " - restart   Restart game.\n" \
              " - (1..9)    Mark a position.\n" \
              "\n>> "

    user_input = get_input(message)

    # Evaluamos si el usuario ingresa una position (Integer) u otra opción.
    if ('1'..'9').to_a.include?(user_input)
      user_input.to_i - 1
    else
      user_input
    end
  end

  def self.get_choice_from_menu
    message = "What do you want to do?\n" \
              "(1) 1 Player mode.\n" \
              "(2) 2 Players mode.\n" \
              "(3) Exit.\n" \
              ">> "
    get_input(message)
  end

  def self.get_player_name(player_num)
    OutputHelper.print_horizontal_line

    default_name = "Player #{player_num}"

    message = "Default name: #{default_name}\n" +
              "Enter player #{player_num} name: "

    player_name = get_input(message)

    player_name.empty? ? default_name : player_name
  end
end
