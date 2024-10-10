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
        content = Jekyll::Euclid::AxiomParser.new.replace_all(content)
        content = Jekyll::Euclid::DefinitionParser.new.replace_all(content)
        content = Jekyll::Euclid::ProofParser.new.replace_all(content)
        Jekyll::Euclid::TheoremParser.new.replace_all(content)
      end

      def convert(content)
        content = parser(content)

        Jekyll::Converters::Markdown::KramdownParser.new(Jekyll.configuration).convert(content)
      end
    end
  end
end
