# frozen_string_literal: true

RSpec.describe Jekyll::Euclid::Parser::TheoremParser do
  it "replaces theorems correctly" do
    content = <<~CONTENT
      \\theorem
      This is a theorem.
      \\end
      \\theorem
      This is another theorem.
      \\end
    CONTENT

    converter = Jekyll::Converters::EuclidConverter.new

    expect(converter.parser(content)).to eq("**Theorem 1:** *This is a theorem.*\n**Theorem 2:** *This is another "\
    "theorem.*\n")
  end

  it "replaces lemmas correctly" do
    content = <<~CONTENT
      \\lemma
      This is a lemma.
      \\end
      \\lemma
      This is another lemma.
      \\end
    CONTENT

    converter = Jekyll::Converters::EuclidConverter.new

    expect(converter.parser(content)).to eq("**Lemma 1:** *This is a lemma.*\n**Lemma 2:** *This is another lemma.*\n")
  end

  it "replaces corollaries correctly" do
    content = <<~CONTENT
      \\theorem
      This is a theorem.
      \\end
      \\corollary
      This is a corollary.
      \\end
      \\corollary
      This is another corollary.
      \\end
    CONTENT

    converter = Jekyll::Converters::EuclidConverter.new

    expect(converter.parser(content)).to eq("**Theorem 1:** *This is a theorem.*\n**Corollary 1.1:** *This is a "\
    "corollary.*\n**Corollary 1.2:** *This is another corollary.*\n")
  end

  it "replaces theorem, lemma, and corollary correctly" do
  end
end
