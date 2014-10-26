module Geschenkt
  class Game
    attr_reader :players, :current_player, :current_card

    def initialize(deck = Deck.new)
      @deck = deck
      @players = []
    end

    def add_player(player_name)
      @players << Player.new(player_name)
    end

    def start
      # check player count

      setup_cards
      setup_players
    end

    def pass_card
      # check game state (started? && !over? && can_pass_card?)

      @current_player.pass_card(@current_card)
      @current_player = @players_cycle.next
    end

    def take_card
      # check game state (started? && !over?)

      @current_player.take_card(@current_card)
      @current_card = @deck.flip_card
    end

    def over?
      # check game state (started? && !over?)

      @current_card.nil?
    end

    def cards_remaining
      @deck.count
    end

    def has_minimum_players?
      players.count >= 3
    end

    def has_maximum_players?
      players.count >= 5
    end

    def can_pass_card?
      current_player.can_pass_card?
    end

    private

    def setup_cards
      @deck.shuffle
      @deck.remove_nine_cards
      @current_card = @deck.flip_card
    end

    def setup_players
      @players.shuffle!
      @players_cycle = @players.cycle
      @current_player = @players_cycle.next
    end
  end
end