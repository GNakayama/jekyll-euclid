# frozen_string_literal: true

module Jekyll
  module Euclid
    # Base class for parsing custom .euclid files
    class BaseParser
      def initialize(name, term)
        @name = name
        @counter = 0
        @size = @name.size + 1
        @term = term
      end

      def replace(content)
        @counter += 1

        "**#{@name} #{@counter}:** *#{content[@size..-6].strip}*"
      end

      def patch_content(content, begin_index, end_index)
        term_content = content[begin_index..(end_index + 3)]
        content_before = begin_index.positive? ? content[0..(begin_index - 1)] : ""
        content_after = content[(end_index + 4)..]

        content_before + replace(term_content) + content_after
      end

      def get_term_indexes(content)
        term_index = content.index(@term)

        return -1, -1 if term_index.nil?

        end_index = content[term_index..].index("\\end") + term_index

        [term_index, end_index]
      end

      def replace_all(content)
        @counter = 0

        term_index, end_index = get_term_indexes(content)

        while term_index >= 0
          content = patch_content(content, term_index, end_index)

          term_index, end_index = get_term_indexes(content)
        end

        content
      end
    end
  end
end
