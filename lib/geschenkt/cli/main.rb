module Geschenkt
  module Cli
    class Main
      include Shared

      def initialize(out = STDOUT)
        @out = out
        @game = Game.new
      end

      def start
        clear_screen

        out.puts Rainbow('Welcome to Geschenkt!').inverse
        blank_line

        AddPlayers.new(@game).execute
        @game.start
        PlayGame.new(@game).execute
        finish_game
      end


      def finish_game
        clear_screen

        out.puts Rainbow('Game over!').inverse
        blank_line

        display_scores
      end

      private

      attr_reader :out

      def display_scores
        out.puts 'Scores:'
        @game.players.sort { |this, that| this.score <=> that.score }.each do |player|
          out.puts Rainbow("  #{player.name}: #{player.score}").cyan
        end

        blank_line
      end
    end
  end
end
