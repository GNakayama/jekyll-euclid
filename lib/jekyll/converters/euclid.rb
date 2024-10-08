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

      def replace_theorem(content)
        @theorem_counter += 1

        "**Theorem #{@theorem_counter}:** *#{content[8..-6].strip}*"
      end

      def replace_lemma(content)
        @theorem_counter += 1

        "**Lemma #{@theorem_counter}:** *#{content[6..-6].strip}*"
      end

      def replace_corollary(content)
        @corollary_counter += 1

        "**Corollary #{@theorem_counter}.#{@corollary_counter}:** *#{content[10..-6].strip}*"
      end

      def replace_axiom(content)
        @axiom_counter += 1

        "**Axiom #{@axiom_counter}:** *#{content[6..-6].strip}*"
      end

      def replace_definition(content)
        @definition_counter += 1

        "**Definition #{@definition_counter}:** *#{content[11..-6].strip}*"
      end

      def replace_proof(content)
        "*Proof.* #{content[7..-6]}"
      end

      def get_term_index(content)
        theorem_index = content.index("\\theorem") || 999_999
        lemma_index = content.index("\\lemma") || 999_999
        corollary_index = content.index("\\corollary") || 999_999

        if theorem_index < lemma_index && theorem_index < corollary_index
          return theorem_index, "\\theorem"
        elsif lemma_index < corollary_index
          return lemma_index, "\\lemma"
        elsif corollary_index < 999_999
          return corollary_index, "\\corollary"
        end

        [-1, nil]
      end

      def replace_theorem_terms(content, term)
        case term
        when "\\theorem"
          replace_theorem(content)
        when "\\lemma"
          replace_lemma(content)
        when "\\corollary"
          replace_corollary(content)
        end
      end

      def replace_theorems(content)
        @theorem_counter = 0

        term_index, term = get_term_index(content)

        term != "\\corollary" && @corollary_counter = 0

        end_index = content[term_index..].index("\\end") + term_index

        while term_index.positive?
          term_content = content[term_index..(end_index + 3)]
          content_before = content[0..(term_index - 1)]
          content_after = content[(end_index + 4)..]
          content = content_before + replace_theorem_terms(term_content, term) + content_after

          term_index, term = get_term_index(content)

          term_index == -1 && break

          end_index = content[term_index..].index("\\end") + term_index
        end

        content
      end

      def replace_term(term, content, replace_method)
        term_index = content.index(term)
        end_index = content[term_index..].index("\\end") + term_index

        while term_index.positive?
          term_content = content[term_index..(end_index + 3)]
          content_before = content[0..(term_index - 1)]
          content_after = content[(end_index + 4)..]
          content = content_before + replace_method.call(term_content) + content_after
          term_index = content.index(term)

          term_index.nil? && break
          end_index = content[term_index..].index("\\end") + term_index

        end

        content
      end

      def replace_axioms(content)
        @axiom_counter = 0
        replace_term("\\axiom", content, method(:replace_axiom))
      end

      def replace_definitions(content)
        @definition_counter = 0
        replace_term("\\definition", content, method(:replace_definition))
      end

      def replace_proofs(content)
        replace_term("\\proof", content, method(:replace_proof))
      end

      def convert(content)
        content = replace_theorems(content)
        content = replace_axioms(content)
        content = replace_definitions(content)
        content = replace_proofs(content)

        Jekyll::Converters::Markdown::KramdownParser.new(Jekyll.configuration).convert(content)
      end
    end
  end
end
