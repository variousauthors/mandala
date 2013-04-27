class Phrase < ActiveRecord::Base
  attr_accessible :content, :hit_points
  belongs_to :passage
end
