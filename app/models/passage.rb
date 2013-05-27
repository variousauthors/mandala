class Passage < ActiveRecord::Base
  attr_accessible :damage, :population, :title, :phrases_attributes

  has_many :phrases
  accepts_nested_attributes_for :phrases

  before_create :default_values

  validates :title, uniqueness: true

  def receives_damage
    self.damage += 1

    self.phrases.each do |phrase|
      phrase.clear_phrase if phrase.should_be_blank_after? self.damage
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
