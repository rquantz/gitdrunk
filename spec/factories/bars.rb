# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bar do
    name "My Bar"

    factory :bar_with_bottles do
      ignore do
        spirits_count 5
      end

      after(:create) do |bar, evaluator|
        bar.spirits << create_list(:spirit, evaluator.spirits_count)
      end
    end
  end
end
