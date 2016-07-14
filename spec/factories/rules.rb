FactoryGirl.define do
  factory :rule, class: Katgut::Rule do
    sequence(:source) {|n| "torsitsugi_test_#{n}" }
    destination 'https://www.google.com/'
    active      true
  end
end
