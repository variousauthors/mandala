class Passage < ActiveRecord::Base
  attr_accessible :damage, :population, :title
  has_many :phrases

  def receives_damage
    self.damage += 1

    self.phrases.each do |phrase|

      if phrase.hit_points <= self.damage
        phrase.destroy

      end

    end

    self.save
  end
end
