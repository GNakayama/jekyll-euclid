# frozen_string_literal: true

require_relative "base"

module Jekyll
  module Euclid
    module Parser
      # AxiomParser class for parsing axioms tags
      class AxiomParser < BaseParser
        def initialize
          super("Axiom", "\\axiom")
        end
      end
    end
  end
end
