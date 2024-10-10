# frozen_string_literal: true

module Jekyll
  module Converters
    # Converts .euclid files, which are a custom format for writing mathematical proofs based on latex math environments
    class EuclidConverter < Converter
      safe true
      priority :highest

      def matches(ext)
        ext =~ /^\.euclid$/i
      end

      def output_ext(_)
        ".html"
      end

      def parser(content)
        content = Jekyll::Euclid::Parser::AxiomParser.new.parse(content)
        content = Jekyll::Euclid::Parser::DefinitionParser.new.parse(content)
        content = Jekyll::Euclid::Parser::ProofParser.new.parse(content)
        Jekyll::Euclid::Parser::TheoremParser.new.parse(content)
      end

      def convert(content)
        content = parser(content)

        Jekyll::Converters::Markdown::KramdownParser.new(Jekyll.configuration).convert(content)
      end
    end
  end
end
