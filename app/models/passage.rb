class Passage < ActiveRecord::Base
  attr_accessible :damage, :population, :title
  has_many :phrases

  def receives_damage
    self.damage += 1

    self.phrases.each do |phrase|

      if !phrase.blank && phrase.hit_points <= self.damage
        phrase.blank = true
        phrase.content = phrase.content.gsub(/./, "&nbsp;")

        phrase.save
      end
    end

    self.save
  end
end
