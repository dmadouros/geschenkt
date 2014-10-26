module Geschenkt
  class Deck
    attr_reader :cards

    def initialize
      @cards = (3..35).map { |value| Card.new(value) }
    end

    def shuffle
      @cards.shuffle!
    end

    def flip_card
      return nil if empty?

      @cards.pop
    end

    def remove_nine_cards
      9.times do
        flip_card
      end
    end

    def empty?
      @cards.empty?
    end

    def count
      @cards.count
    end
  end
end