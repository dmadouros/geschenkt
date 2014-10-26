module Geschenkt
  module Cli
    class PlayGame
      include Shared

      def initialize(game, out = STDOUT)
        @game = game
        @out = out
      end

      def execute
        until @game.over? do
          clear_screen

          response = nil

          until valid?(response) do
            display_game_state
            display_player_stats
            display_player_options

            response = get_user_response

            unless valid?(response)
              clear_screen
              invalid_response
            end
          end

          if take_card?(response)
            @game.take_card
          else
            @game.pass_card
          end
        end
      end

      private

      attr_reader :out

      def valid?(response)
        take_card?(response) || (@game.can_pass_card? && pass_card?(response))
      end

      def take_card?(response)
        ['1', 't'].include?(response)
      end

      def pass_card?(response)
        ['2', 'p'].include?(response)
      end

      def display_game_state
        out.puts "OK, #{Rainbow(@game.current_player.name).cyan.underline}. It's your turn."
        blank_line
        out.puts "There are #{@game.cards_remaining} cards left in the deck."
        out.puts Rainbow("The current card is #{@game.current_card.value} and it has #{@game.current_card.chips} chips on it.").green
        blank_line
      end

      def display_player_stats
        out.puts Rainbow("Your cards are: #{@game.current_player.cards.map(&:value).sort}.").green
        out.puts Rainbow("You have #{@game.current_player.chips} chips.").green
        out.puts "Your current score is #{@game.current_player.score}."
        blank_line
      end

      def display_player_options
        out.puts Rainbow("What would you like to do:").blue.bright
        out.puts Rainbow("  1. Take the card").blue.bright

        if @game.can_pass_card?
          out.puts Rainbow("  2. Pass on the card (by putting a chip on it)").blue.bright
        end

        prompt
      end
    end
  end
end