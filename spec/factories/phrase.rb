FactoryGirl.define do
  factory :phrase do
    content "Generic room description."
    hit_points 10
    blank false
    details { |d| [ d.association(:detail) ] }
  end
end
