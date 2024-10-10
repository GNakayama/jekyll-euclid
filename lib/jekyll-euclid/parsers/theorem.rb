# frozen_string_literal: true

module Jekyll
  module Euclid
    # TheoremParser class for parsing theorem, lemma, and corollary tags
    class TheoremParser
      def initialize
        @counter = 0
        @corollary_counter = 0
        @theorem_term = "\\theorem"
        @lemma_term = "\\lemma"
        @corollary_term = "\\corollary"
        @theorem_size = @theorem_term.size + 1
        @lemma_size = @lemma_term.size + 1
        @corollary_size = @corollary_term.size + 1
        @terms = [@theorem_term, @lemma_term, @corollary_term]
      end

      def replace_theorem(content)
        @counter += 1

        "**Theorem #{@counter}:** *#{content[8..-6].strip}*"
      end

      def replace_lemma(content)
        @counter += 1

        "**Lemma #{@counter}:** *#{content[6..-6].strip}*"
      end

      def replace_corollary(content)
        @corollary_counter += 1

        "**Corollary #{@counter}.#{@corollary_counter}:** *#{content[10..-6].strip}*"
      end

      def find_first(terms, content)
        current_index = -1
        current_term = nil

        terms.each do |term|
          index = content.index(term)

          next if index.nil? || (current_index >= 0 && index >= current_index)

          current_index = index
          current_term = term
        end

        [current_index, current_term]
      end

      def replace_theorem_terms(content, term)
        case term
        when @theorem_term
          replace_theorem(content)
        when @lemma_term
          replace_lemma(content)
        when @corollary_term
          replace_corollary(content)
        end
      end

      def patch_content(content, begin_index, end_index, term)
        term_content = content[begin_index..(end_index + 3)]
        content_before = begin_index.positive? ? content[0..(begin_index - 1)] : ""
        content_after = content[(end_index + 4)..]

        content_before + replace_theorem_terms(term_content, term) + content_after
      end

      def get_term_indexes(terms, content)
        term_index, term = find_first(terms, content)

        return -1, -1, nil if term_index.negative?

        end_index = content[term_index..].index("\\end") + term_index

        [term_index, end_index, term]
      end

      def replace_all(content)
        @counter = 0

        term_index, end_index, term = get_term_indexes([@theorem_term, @lemma_term, @corollary_term], content)

        term != "\\corollary" && @corollary_counter = 0

        while term_index >= 0
          content = patch_content(content, term_index, end_index, term)
          term_index, end_index, term = get_term_indexes([@theorem_term, @lemma_term, @corollary_term], content)
        end

        content
      end
    end
  end
end
