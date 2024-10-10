# frozen_string_literal: true

require "jekyll"
require "jekyll-euclid/parsers/axiom"
require "jekyll-euclid/parsers/definition"
require "jekyll-euclid/parsers/theorem"
require "jekyll-euclid/parsers/proof"

require File.expand_path("jekyll/converters/euclid", File.dirname(__FILE__))

module Jekyll
  # Euclid converter for Jekyll
  module EuclidConverter
  end
end
