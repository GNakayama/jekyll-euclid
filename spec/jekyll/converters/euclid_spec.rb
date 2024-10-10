# frozen_string_literal: true

RSpec.describe Jekyll::Euclid do
  it "has a version number" do
    expect(Jekyll::Euclid::VERSION).not_to be nil
  end

  it "replaces axioms correctly" do
    content = <<~CONTENT
      \\axiom
      This is an axiom.
      \\end
      \\axiom
      This is another axiom.
      \\end
    CONTENT

    converter = Jekyll::Converters::EuclidConverter.new

    expect(converter.parser(content)).to eq("**Axiom 1:** *This is an axiom.*\n**Axiom 2:** *This is another axiom.*\n")
  end

  it "replaces definitions correctly" do
    content = <<~CONTENT
      \\definition
      This is a definition.
      \\end
      \\definition
      This is another definition.
      \\end
    CONTENT

    converter = Jekyll::Converters::EuclidConverter.new

    expect(converter.parser(content)).to eq("**Definition 1:** *This is a definition.*\n**Definition 2:** *This is another definition.*\n")
  end

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

    expect(converter.parser(content)).to eq("**Theorem 1:** *This is a theorem.*\n**Theorem 2:** *This is another theorem.*\n")
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

    expect(converter.parser(content)).to eq("**Theorem 1:** *This is a theorem.*\n**Corollary 1.1:** *This is a corollary" \
      ".*\n**Corollary 1.2:** *This is another corollary.*\n")
  end

  it "replaces theorem, lemma, and corollary correctly" do
  end
end
