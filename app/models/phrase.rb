class Phrase < ActiveRecord::Base
  attr_accessible :content, :hit_points
  belongs_to :passage

  # returns the opacity at which this phrase should be displayed,
  # as calculated by its damage rating
  def opacity
    hit_points_left = self.hit_points - self.passage.damage
    ratio = hit_points_left / self.hit_points.to_f

    return ratio.to_s
  end

end
