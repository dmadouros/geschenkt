module Geschenkt
  class Player
    attr_reader :name, :chips, :cards

    def initialize(name)
      # check name is not blank

      @name = name
      @chips = 11
      @cards = []
    end

    def pass_card(card)
      remove_chip
      card.add_chip
    end

    def take_card(card)
      @cards << card
      @chips += card.remove_chips
    end

    def score
      ScoreCalculator.new(@cards.map(&:value).sort).execute - @chips
    end

    def can_pass_card?
      chips > 0
    end

    private

    def remove_chip
      @chips -= 1
    end
  end
end