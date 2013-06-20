class Phrase < ActiveRecord::Base
  attr_accessible :content, :hit_points, :blank, :details_attributes
  belongs_to :passage

  before_create :default_values

  has_many :details
  accepts_nested_attributes_for :details

  # returns the opacity at which this phrase should be displayed,
  # as calculated by its damage rating
  def opacity
    hit_points_left = self.hit_points - self.passage.damage
    ratio = hit_points_left / self.hit_points.to_f

    return [ratio, 0].max.to_s
  end

  def clear_phrase
    self.blank = true
    self.content = self.content.gsub(/./, "&nbsp;")

    self.save
  end

  def should_be_blank_after?(damage)
    !self.blank && self.hit_points <= damage
  end

  private

  def default_values
    self.hit_points ||= 1000

  end
end
