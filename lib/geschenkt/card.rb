module Geschenkt
  class Card
    attr_reader :chips, :value

    def initialize(value)
      # check value is between 3-35

      @value = value
      @chips = 0
    end

    def add_chip
      @chips += 1
    end

    def remove_chips
      current_chips = @chips
      @chips = 0
      current_chips
    end
  end
end