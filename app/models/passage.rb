class Passage < ActiveRecord::Base
  attr_accessible :damage, :population, :title
  has_many :phrases
end
