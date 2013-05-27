require 'spec_helper'

describe Phrase do
  let(:passage) { FactoryGirl.create(:passage) }
  let(:damaged_passage) { FactoryGirl.create(:passage, damage: 9) }
  let(:passage_with_half_dead_phrase) { FactoryGirl.create(:passage, damage: 5) }

  it "has a valid factory" do
    phrase = passage.phrases.first
    phrase.should be_valid
  end

  describe "#opacity" do
    it "returns a string" do
      phrase = passage.phrases.first
      phrase.opacity.should be_a(String)
    end

    it "returns .5 for a half-dead phrase" do
      phrase = passage_with_half_dead_phrase.phrases.first
      phrase.opacity.should eq "0.5"
    end

    it "returns 0 for a dead phrase" do
      phrase = damaged_passage.phrases.first

      damaged_passage.receives_damage
      phrase.opacity.should eq "0.0"
    end
  end

  describe "#should_be_blank_after?" do
    it "is false before damage meets hit points" do
      phrase = passage.phrases.first
      phrase.should_be_blank_after?(5).should be_a(FalseClass)
    end

    it "is true when damage meets hit points" do
      phrase = passage.phrases.first
      phrase.should_be_blank_after?(10).should be_a(TrueClass)
    end
  end

  describe "#clear_phrase" do
    it "sets blank to true" do
      phrase = passage.phrases.first
      phrase.clear_phrase

      phrase.blank.should be_a(TrueClass)
    end

    it "replaces contents with whitespace" do
      phrase = passage.phrases.first
      length = phrase.content.length
      phrase.clear_phrase

      blanks = "&nbsp;" * length
      phrase.content.should eq blanks
    end
  end
end
