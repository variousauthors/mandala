FactoryGirl.define do
  factory :passage do
    damage 0
    population 0
    title "the room"
    phrases { |p| [ p.association(:phrase) ] }
  end

  trait :second_passage do
    title "a second passage"
  end

  trait :perimeter do
    id 1
  end
end
