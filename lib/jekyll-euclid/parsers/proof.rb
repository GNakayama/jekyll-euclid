# frozen_string_literal: true

module Jekyll
  module Euclid
    # ProofParser class for parsing proof tags
    class ProofParser < BaseParser
      def initialize
        super("Proof", "\\proof")
      end

      def replace(content)
        @counter += 1

        "*#{@name}.* #{content[@size..-6].strip}"
      end
    end
  end
end
