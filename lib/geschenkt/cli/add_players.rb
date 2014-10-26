module Geschenkt
  module Cli
    class AddPlayers
      include Shared

      def initialize(game, out = STDOUT)
        @game = game
        @out = out
      end

      def execute
        while true do
          until @game.has_minimum_players? do
            add_player
          end

          response = nil
          until valid?(response)
            display_players
            display_options
            response = get_user_response

            clear_screen
            unless valid?(response)
              invalid_response
            end
          end

          if add_player?(response)
            add_player
          else
            return
          end
        end
      end

      private

      attr_reader :out

      def add_player?(response)
        response == '1'
      end

      def start_game?(response)
        response == '2'
      end

      def add_player
        display_players
        out.puts Rainbow('Please add a player:').blue.bright
        prompt

        name = get_user_response
        @game.add_player(name)

        clear_screen
      end

      def valid?(response)
        (!@game.has_maximum_players? && add_player?(response)) ||
          (@game.has_minimum_players? && start_game?(response))
      end

      def display_players
        out.puts 'Players: '
        @game.players.map(&:name).each do |player_name|
          out.puts Rainbow("  #{player_name}").cyan
        end
        blank_line
      end

      def display_options
        out.puts Rainbow('Would you like to: ').blue.bright

        unless  @game.has_maximum_players?
          out.puts Rainbow('  1. Add another player').blue.bright
        end

        if @game.has_minimum_players?
          out.puts Rainbow('  2. Start the game').blue.bright
        end

        prompt
      end
    end
  end
end