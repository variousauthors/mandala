class Phrase < ActiveRecord::Base
  attr_accessible :content, :hit_points, :blank, :details_attributes
  belongs_to :passage

  has_many :details
  accepts_nested_attributes_for :details

  # returns the opacity at which this phrase should be displayed,
  # as calculated by its damage rating
  def opacity
    hit_points_left = self.hit_points - self.passage.damage
    ratio = hit_points_left / self.hit_points.to_f

    return [ratio, 0].max.to_s
  end

end
