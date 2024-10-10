# frozen_string_literal: true

RSpec.describe Jekyll::Euclid::Parser::ProofParser do
  it "replaces proofs correctly" do
    content = <<~CONTENT
      \\proof
      This is a proof.
      \\end
      \\proof
      This is another proof.
      \\end
    CONTENT

    converter = Jekyll::Converters::EuclidConverter.new

    expect(converter.parser(content)).to eq("*Proof.* This is a proof.\n*Proof.* This is another proof.\n")
  end
end
