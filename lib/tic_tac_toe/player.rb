# frozen_string_literal: true

require_relative '../helpers/input_helper'

# Player class
class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end
end
