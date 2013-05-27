require 'spec_helper'

describe Passage do
  let(:passage) { FactoryGirl.build(:passage) }
  let(:damaged_passage) { FactoryGirl.build(:passage, damage: 9) }

  it "has a valid factory" do
    passage.should be_valid
  end

  describe "receives_damage" do
    it "receives damage" do
      expect { passage.receives_damage }.to change { passage.damage }.from(0).to(1)
    end

    # should write a custom matcher for 'blanks_phrases'
    it "blanks its phrases when they take enough damage" do
      phrase = damaged_passage.phrases.first

      damaged_passage.receives_damage

      expect(phrase.content.strip).to match ""
    end
  end
end
