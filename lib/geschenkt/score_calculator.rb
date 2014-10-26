module Geschenkt
  class ScoreCalculator
    def initialize(cards)
      @cards = cards
    end

    def execute
      return 0 if @cards.empty?

      sorted_runs.reduce(0) do |score, run|
        score += run.first
        score
      end
    end

    private

    def sorted_runs
      runs = []
      run = []
      @cards.each_with_index do |current_card, index|
        run << current_card

        next_card = @cards[index + 1]
        unless next_card == current_card + 1
          runs << run
          run = []
        end
      end

      runs
    end
  end
end