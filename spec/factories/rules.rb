FactoryGirl.define do
  factory :rule, class: Toritsugi::Rule do
    sequence(:source) {|n| "torsitsugi_test_#{n}" }
    destination 'https://www.google.com/'
    active      true
  end
end
