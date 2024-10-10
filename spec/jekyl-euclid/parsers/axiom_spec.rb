# frozen_string_literal: true

RSpec.describe Jekyll::Euclid::Parser::AxiomParser do
  it "replaces axioms correctly" do
    content = <<~CONTENT
      \\axiom
      This is an axiom.
      \\end
      \\axiom
      This is another axiom.
      \\end
    CONTENT

    parser = Jekyll::Euclid::Parser::AxiomParser.new

    expect(parser.parse(content)).to eq("**Axiom 1:** *This is an axiom.*\n**Axiom 2:** *This is another axiom.*\n")
  end
end
