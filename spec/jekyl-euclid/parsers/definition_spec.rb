# frozen_string_literal: true

RSpec.describe Jekyll::Euclid::Parser::DefinitionParser do
  it "replaces definitions correctly" do
    content = <<~CONTENT
      \\definition
      This is a definition.
      \\end
      \\definition
      This is another definition.
      \\end
    CONTENT

    parser = Jekyll::Euclid::Parser::DefinitionParser.new

    expect(parser.parse(content)).to eq("**Definition 1:** *This is a definition.*\n**Definition 2:** *This is "\
    "another definition.*\n")
  end
end
