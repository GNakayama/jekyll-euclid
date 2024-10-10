# frozen_string_literal: true

module Jekyll
  module Euclid
    # DefinitionParser class for parsing definition tags
    class DefinitionParser < BaseParser
      def initialize
        super("Definition", "\\definition")
      end
    end
  end
end
