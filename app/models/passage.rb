class Passage < ActiveRecord::Base
  attr_accessible :damage, :population, :title, :phrases_attributes

  has_many :phrases
  accepts_nested_attributes_for :phrases

  before_create :default_values

  validates :title, uniqueness: true

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

  # a method like this may be necessary
  # def self.phrases
  #  phrases = super
  #
  #  return phrases.order(:id)
  # end

  private
  def default_values
    self.population ||= 0
    self.damage ||= 0

  end
end
