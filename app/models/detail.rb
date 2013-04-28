class Detail < ActiveRecord::Base
  attr_accessible :content, :keyword, :phrase_id
  belongs_to :phrase

  validates :keyword, uniqueness: true

  def to_param

    self.keyword
  end
end
