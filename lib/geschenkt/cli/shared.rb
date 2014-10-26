require 'rainbow'

module Geschenkt
  module Cli
    module Shared
      def get_user_response
        gets.chomp
      end

      def clear_screen
        system "clear" or system "cls"
      end

      def prompt
        out.print Rainbow('> ').blue.bright
      end

      def invalid_response
        out.puts Rainbow("Invalid response! Let's try again.").white.bg(:red)
        blank_line
      end

      def blank_line
        out.puts
      end
    end
  end
end