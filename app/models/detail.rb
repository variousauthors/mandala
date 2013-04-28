class Detail < ActiveRecord::Base
  attr_accessible :content, :keyword, :phrase_id
  belongs_to :phrase

end
